//
//  AuthManager.swift
//  PlantMama
//
//  Created by Vanessa Bennett on 7/3/26.
//


import Foundation
import FirebaseAuth
import GoogleSignIn
import FirebaseCore
import FirebaseFirestore

@MainActor
class AuthManager: ObservableObject {
    @Published var currentUser: User? = nil
    @Published var authError: String? = nil
    @Published var isInitialCheckComplete = false
    private let db = Firestore.firestore()
    
    init() {
        // Monitor authentication state changes across the app
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let self = self else { return }
            self.currentUser = user
            self.isInitialCheckComplete = true
        }
    }
    
    func signUpWithEmail(email: String, password: String) async {
        do {
            let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
            let user = authResult.user
            
            try await db.collection("users").document(user.uid).setData([
                "uid": user.uid,
                "email": email,
                "createdAt": Timestamp(date: Date())
            ])
            self.authError = nil
        } catch {
            self.authError = error.localizedDescription
        }
    }
    
    func loginWithEmail(email: String, password: String) async {
        do {
            _ = try await Auth.auth().signIn(withEmail: email, password: password)
            self.authError = nil
        } catch {
            self.authError = error.localizedDescription
        }
    }
    
    func signInWithGoogle() async {
        // 1. Fetch the Client ID dynamically from your active Firebase configuration
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            self.authError = "Firebase is not configured correctly."
            return
        }
        
        // 2. Create the Google configuration object and assign it to the shared instance
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config // <-- Fixes the "No active configuration" crash
        
        // 3. Get the root view controller needed by the Google SDK
        guard let rootViewController = await UIApplication.shared.windows.first?.rootViewController else {
            self.authError = "Could not find root view controller."
            return
        }
        
        do {
            // 2. Trigger native Google Sign-In presentation
            let signInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
            let googleUser = signInResult.user
            
            // 3. Exchange tokens for a Firebase Credential
            guard let idToken = googleUser.idToken?.tokenString else {
                self.authError = "Missing Google ID Token."
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: googleUser.accessToken.tokenString)
            
            // 4. Authorize session into Firebase Auth
            let authResult = try await Auth.auth().signIn(with: credential)
            let user = authResult.user
            
            let userDocRef = db.collection("users").document(user.uid)
            let document = try await userDocRef.getDocument()
            
            // 3. Only provision the document if they are brand new!
            if !document.exists {
                try await userDocRef.setData([
                    "uid": user.uid,
                    "email": user.email ?? "",
                    "createdAt": Timestamp(date: Date()),
                    "displayName": googleUser.profile?.name ?? ""
                ])
            }
            
            
            self.authError = nil
        } catch {
            self.authError = error.localizedDescription
        }
    }
    
    func signOut() {
        try? Auth.auth().signOut()
    }
}
