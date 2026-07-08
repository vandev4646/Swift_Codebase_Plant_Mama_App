//
//  FirestoreSyncManager.swift
//  PlantMama
//
//  Created by Vanessa Bennett on 7/3/26.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import SwiftData

@MainActor
class FirestoreSyncManager: ObservableObject {
    private let firestore = Firestore.firestore()
    //listener based on user sign in
    private var authListenerHandle: AuthStateDidChangeListenerHandle?
    private var userId: String? {
        Auth.auth().currentUser?.uid
    }
    
    init(context: ModelContext) {
        setupAuthListener(context: context)
    }
    
    deinit {
        if let handle = authListenerHandle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    func backupPlant(plant: Plant, context: ModelContext) {
        guard let currentUserId = userId else {
            print("No user is currently signed in. Skipping backup.")
            return
        }
        
        let plantDto = PlantDocument(
            UUID: plant.id.uuidString,
            profilePic: plant.profilePic.identifier,
            name: plant.name,
            datePurchased: plant.datePurchased,
            type: plant.type,
            description: plant.details,
            lastUpdated: plant.lastUpdated
        )
        
        Task.detached(priority: .background) { [firestore] in
            do {
                try await firestore.collection("users").document(currentUserId)
                    .collection("plants").document(plant.id.uuidString)
                    .setData(from: plantDto)
                //return to main thread to update sync status
                await MainActor.run {
                    plant.syncState = SyncState.SYNCED
                    try? context.save()
                }
                print("Successfully queued/uploaded plant backup: \(plant.name)")
            } catch {
                print("Firestore backup failed: \(error.localizedDescription)")
            }
        }
        
    }
    
    func deleteBackupPlant(plant: Plant, context: ModelContext){
        guard let currentUserId = userId else {
            print("No user is currently signed in. Skipping backup.")
            return
        }
        
        Task.detached(priority: .background) { [firestore] in
            do {
                //return to main thread to update sync status to tombstone item
                await MainActor.run {
                    plant.syncState = SyncState.TO_DELETE
                    try? context.save()
                }
                try await firestore.collection("users").document(currentUserId)
                    .collection("plants").document(plant.id.uuidString).delete()
                
                print("Plant was sucessfully deleted from Firestore")
            } catch {
                print("Firestore backup failed: \(error.localizedDescription)")
            }
        }
        
    }
    
    
    func backupPhoto(photo: Photo, context: ModelContext) {
        guard let currentUserId = userId else {
            print("No user is currently signed in. Skipping backup.")
            return
        }
        
        let photoDto = PhotoDocument(
            UUID: photo.id.uuidString,
            uri: photo.identifier,
            lastUpdated: photo.lastUpdated
        )
        
        Task.detached(priority: .background) { [firestore] in
            do {
                try await firestore
                    .collection("users")
                    .document(currentUserId)
                    .collection("plants").document(photo.plant?.id.uuidString ?? "0")
                    .collection("photos").document(photo.id.uuidString)
                    .setData(from: photoDto)
                //return to main thread to update sync status
                await MainActor.run {
                    photo.syncState = SyncState.SYNCED
                    try? context.save()
                }
                print(
                    "Successfully queued/uploaded photo backup: \(photo.identifier)"
                )
            } catch {
                print("Firestore backup failed: \(error.localizedDescription)")
            }
        }
        
    }
    
    func deleteBackupPhoto(photo: Photo, context: ModelContext){
        guard let currentUserId = userId else {
            print("No user is currently signed in. Skipping backup.")
            return
        }
        
        Task.detached(priority: .background) { [firestore] in
            do {
                //return to main thread to update sync status to tombstone item
                await MainActor.run {
                    photo.syncState = SyncState.TO_DELETE
                    try? context.save()
                }
                try await firestore.collection("users").document(currentUserId).collection("plants").document(photo.plant?.id.uuidString ?? "0")
                    .collection("photos").document(photo.id.uuidString).delete()
                
                print("Photos was sucessfully deleted from Firestore")
            } catch {
                print("Firestore backup failed: \(error.localizedDescription)")
            }
        }
        
    }
    
    func backupNote(note: Note, context: ModelContext) {
        guard let currentUserId = userId else {
            print("No user is currently signed in. Skipping backup.")
            return
        }
        
        let noteDto = NoteDocument(
            UUID: note.id.uuidString,
            title: note.title,
            date: note.date,
            photoRoomIds: note.photos.map({$0.id.uuidString}),
            lastUpdated: note.lastUpdated
        )
        
        Task.detached(priority: .background) { [firestore] in
            do {
                try await firestore.collection("users").document(currentUserId).collection("plants").document(note.plant?.id.uuidString ?? "0")
                    .collection("notes").document(note.id.uuidString)
                    .setData(from: noteDto)
                //return to main thread to update sync status
                await MainActor.run {
                    note.syncState = SyncState.SYNCED
                    try? context.save()
                }
                print("Successfully queued/uploaded note backup: \(note.title)")
            } catch {
                print("Firestore backup failed: \(error.localizedDescription)")
            }
        }
        
    }
    
    
    func deleteBackupNote(note: Note, context: ModelContext){
        guard let currentUserId = userId else {
            print("No user is currently signed in. Skipping backup.")
            return
        }
        
        Task.detached(priority: .background) { [firestore] in
            do {
                //return to main thread to update sync status to tombstone item
                await MainActor.run {
                    note.syncState = SyncState.TO_DELETE
                    try? context.save()
                }
                try await firestore.collection("users").document(currentUserId).collection("plants").document(note.plant?.id.uuidString ?? "0")
                    .collection("notes").document(note.id.uuidString).delete()
                
                print("Note was sucessfully deleted from Firestore")
            } catch {
                print("Firestore backup failed: \(error.localizedDescription)")
            }
        }
        
    }
    
    func backupReminder(reminder: Reminder, context: ModelContext) {
        guard let currentUserId = userId else {
            print("No user is currently signed in. Skipping backup.")
            return
        }
        
        let reminderDto = ReminderDocument(
            UUID: reminder.id.uuidString,
            wmIdentifier: reminder.id.uuidString,
            title: reminder.title,
            date: reminder.date,
            frequency: reminder.frequency.rawValue,
            interval: reminder.monthlyInterval,
            lastUpdated: reminder.lastUpdated
        )
        
        Task.detached(priority: .background) { [firestore] in
            do {
                try await firestore.collection("users").document(currentUserId).collection("plants").document(reminder.plant?.id.uuidString ?? "0")
                    .collection("reminders").document(reminder.id.uuidString)
                    .setData(from: reminderDto)
                //return to main thread to update sync status
                await MainActor.run {
                    reminder.syncState = SyncState.SYNCED
                    try? context.save()
                }
                print(
                    "Successfully queued/uploaded reminder backup: \(reminder.title)"
                )
            } catch {
                print("Firestore backup failed: \(error.localizedDescription)")
            }
        }
        
    }
    
    func deleteBackupReminder(reminder: Reminder, context: ModelContext){
        guard let currentUserId = userId else {
            print("No user is currently signed in. Skipping backup.")
            return
        }
        
        Task.detached(priority: .background) { [firestore] in
            do {
                //return to main thread to update sync status to tombstone item
                await MainActor.run {
                    reminder.syncState = SyncState.TO_DELETE
                    try? context.save()
                }
                try await firestore.collection("users").document(currentUserId).collection("plants").document(reminder.plant?.id.uuidString ?? "0")
                    .collection("reminders").document(reminder.id.uuidString).delete()
                
                print("Reminder was sucessfully deleted from Firestore")
            } catch {
                print("Firestore backup failed: \(error.localizedDescription)")
            }
        }
        
    }
    
    
    func syncAllDataOnLogin(context: ModelContext) async {
    guard let currentUserId = userId else {
        print("No user signed in. Skipping sync.")
        return
    }
    
    print("Starting hierarchical two-way multi-model sync...")
    
    // ==========================================
    // STEP 1: PUSH ALL UNSYNCED LOCAL CHANGES UP
    // ==========================================
    do {
        // Fetch all elements unconditionally to bypass SwiftData enum query bugs
        let allPlants = try context.fetch(FetchDescriptor<Plant>())
        let allPhotos = try context.fetch(FetchDescriptor<Photo>())
        let allNotes = try context.fetch(FetchDescriptor<Note>())
        let allReminders = try context.fetch(FetchDescriptor<Reminder>())
        
        // Filter out unsynced objects in memory
        let unsyncedPlants = allPlants.filter { $0.syncState != SyncState.SYNCED }
        let unsyncedPhotos = allPhotos.filter { $0.syncState != SyncState.SYNCED }
        let unsyncedNotes = allNotes.filter { $0.syncState != SyncState.SYNCED }
        let unsyncedReminders = allReminders.filter { $0.syncState != SyncState.SYNCED }
        
        // Run uploads using your updated subcollection path definitions
        unsyncedPlants.forEach { $0.syncState == SyncState.TO_DELETE ? deleteBackupPlant(plant: $0, context: context) : backupPlant(plant: $0, context: context) }
        unsyncedPhotos.forEach { $0.syncState == SyncState.TO_DELETE ? deleteBackupPhoto(photo: $0, context: context) : backupPhoto(photo: $0, context: context) }
        unsyncedNotes.forEach { $0.syncState == SyncState.TO_DELETE ? deleteBackupNote(note: $0, context: context) : backupNote(note: $0, context: context) }
        unsyncedReminders.forEach { $0.syncState == SyncState.TO_DELETE ? deleteBackupReminder(reminder: $0, context: context) : backupReminder(reminder: $0, context: context) }
        
    } catch {
        print("Error uploading local data: \(error.localizedDescription)")
    }
    
    // ==========================================
    // STEP 2: DOWNLOAD & MERGE NESTED DATA FROM THE CLOUD
    // ==========================================
    let userRef = firestore.collection("users").document(currentUserId)
    
    // 1. Download all plants first to know which subcollection trees to read
    let remotePlants = await Task.detached(priority: .background) { [userRef] in
        let snap = try? await userRef.collection("plants").getDocuments()
        return snap?.documents.compactMap { try? $0.data(as: PlantDocument.self) } ?? []
    }.value
    
    // 2. Perform safe, non-optional matching photo asset preparation
    let defaultPhoto = Photo(id: UUID(), identifier: "Default")
    defaultPhoto.syncState = SyncState.SYNCED
    context.insert(defaultPhoto)
    
    // 3. Process each plant subcollection structure sequentially
    for remotePlant in remotePlants {
        guard let plantUUID = UUID(uuidString: remotePlant.UUID) else { continue }
        let plantIdString = remotePlant.UUID
        
        // Match up or insert the local Plant object instance
        var localPlant: Plant
        if let existingPlant = try? context.fetch(FetchDescriptor<Plant>(predicate: #Predicate<Plant> { $0.id == plantUUID })).first {
            localPlant = existingPlant
            if remotePlant.lastUpdated > existingPlant.lastUpdated {
                existingPlant.name = remotePlant.name
                existingPlant.datePurchased = remotePlant.datePurchased
                existingPlant.type = remotePlant.type
                existingPlant.details = remotePlant.description
                existingPlant.lastUpdated = remotePlant.lastUpdated
                existingPlant.syncState = SyncState.SYNCED
            }
        } else {
            localPlant = Plant(
                id: plantUUID,
                name: remotePlant.name,
                profilePic: defaultPhoto,
                datePurchased: remotePlant.datePurchased,
                type: remotePlant.type,
                details: remotePlant.description
            )
            localPlant.syncState = SyncState.SYNCED
            context.insert(localPlant)
        }
        
        // 4. Download nested child subcollections for this specific plant concurrently
        let plantDocRef = userRef.collection("plants").document(plantIdString)
        
        let (remotePhotos, remoteNotes, remoteReminders) = await Task.detached(priority: .background) { [plantDocRef] in
            async let photosSnap = try? plantDocRef.collection("photos").getDocuments().documents.compactMap { try? $0.data(as: PhotoDocument.self) }
            async let notesSnap = try? plantDocRef.collection("notes").getDocuments().documents.compactMap { try? $0.data(as: NoteDocument.self) }
            async let remindersSnap = try? plantDocRef.collection("reminders").getDocuments().documents.compactMap { try? $0.data(as: ReminderDocument.self) }
            
            return (await photosSnap ?? [], await notesSnap ?? [], await remindersSnap ?? [])
        }.value
        
        // --- A. MERGE NESTED PHOTOS ---
        for remotePhoto in remotePhotos {
            guard let photoUUID = UUID(uuidString: remotePhoto.UUID) else { continue }
            if let localPhoto = try? context.fetch(FetchDescriptor<Photo>(predicate: #Predicate<Photo> { $0.id == photoUUID })).first {
                if remotePhoto.lastUpdated > localPhoto.lastUpdated {
                    localPhoto.identifier = remotePhoto.uri
                    localPhoto.lastUpdated = remotePhoto.lastUpdated
                    localPhoto.syncState = SyncState.SYNCED
                }
            } else {
                let newPhoto = Photo(id: photoUUID, identifier: remotePhoto.uri)
                newPhoto.syncState = SyncState.SYNCED
                context.insert(newPhoto)
                // If your design matches photos directly to plants, append them here:
                // localPlant.photos.append(newPhoto)
            }
        }
        
        // --- B. MERGE NESTED REMINDERS ---
        for remoteReminder in remoteReminders {
            guard let reminderUUID = UUID(uuidString: remoteReminder.UUID) else { continue }
            if let localReminder = try? context.fetch(FetchDescriptor<Reminder>(predicate: #Predicate<Reminder> { $0.id == reminderUUID })).first {
                if remoteReminder.lastUpdated > localReminder.lastUpdated {
                    localReminder.title = remoteReminder.title
                    localReminder.date = remoteReminder.date
                    if let freq = Frequency(rawValue: remoteReminder.frequency) { localReminder.frequency = freq }
                    localReminder.monthlyInterval = remoteReminder.interval
                    localReminder.lastUpdated = remoteReminder.lastUpdated
                    localReminder.syncState = SyncState.SYNCED
                }
            } else {
                let freq = Frequency(rawValue: remoteReminder.frequency) ?? .once
                let newReminder = Reminder(id: reminderUUID, title: remoteReminder.title, date: remoteReminder.date, frequency: freq, monthlyInterval: remoteReminder.interval)
                newReminder.syncState = SyncState.SYNCED
                context.insert(newReminder)
                
                // Establish the relationship under the plant parent record
                if !localPlant.reminders.contains(where: { $0.id == reminderUUID }) {
                    localPlant.reminders.append(newReminder)
                }
                NotificationUtility.scheduleNotification(
title: remoteReminder.title + "'s" + " reminder",
body: remoteReminder.title,
date: remoteReminder.date,
identifier: remoteReminder.wmIdentifier,
frequency: Frequency(
    rawValue: remoteReminder.frequency
) ?? Frequency.once,
interval: remoteReminder.interval
                )
            }
        }
        
        // --- C. MERGE NESTED NOTES ---
        for remoteNote in remoteNotes {
            guard let noteUUID = UUID(uuidString: remoteNote.UUID) else { continue }
            
            let associatedPhotos = remoteNote.photoRoomIds.compactMap { idStr -> Photo? in
                guard let pUUID = UUID(uuidString: idStr) else { return nil }
                return try? context.fetch(FetchDescriptor<Photo>(predicate: #Predicate<Photo> { $0.id == pUUID })).first
            }
            
            if let localNote = try? context.fetch(FetchDescriptor<Note>(predicate: #Predicate<Note> { $0.id == noteUUID })).first {
                if remoteNote.lastUpdated > localNote.lastUpdated {
                    localNote.title = remoteNote.title
                    localNote.date = remoteNote.date
                    localNote.photos = associatedPhotos
                    localNote.lastUpdated = remoteNote.lastUpdated
                    localNote.syncState = SyncState.SYNCED
                }
            } else {
                let newNote = Note(id: noteUUID, title: remoteNote.title, date: remoteNote.date)
                newNote.photos = associatedPhotos
                newNote.syncState = SyncState.SYNCED
                context.insert(newNote)
                
                // Establish the relationship under the plant parent record
                if !localPlant.noteList.contains(where: { $0.id == noteUUID }) {
                    localPlant.noteList.append(newNote)
                }
            }
        }
        
        // Resolve profile picture assignment post-photo extraction
        if let photoUUID = UUID(uuidString: remotePlant.profilePic),
           let resolvedPhoto = try? context.fetch(FetchDescriptor<Photo>(predicate: #Predicate<Photo> { $0.id == photoUUID })).first {
            localPlant.profilePic = resolvedPhoto
        }
    }
    
    // ==========================================
    // STEP 3: PERSIST EVERYTHING
    // ==========================================
    do {
        try context.save()
        print("Hierarchical sync completed successfully.")
    } catch {
        print("Error saving context after nested sync: (error.localizedDescription)")}}

    
    
    private func setupAuthListener(context: ModelContext) {
        // This block fires immediately upon setup, and every time user state changes
        authListenerHandle = Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            guard let self = self else { return }
            
            if let activeUser = user {
                print("User signed in successfully: \(activeUser.uid). Triggering sync...")
                
                // Detach a task to handle the async sync function safely from the listener callback
                Task {
                    await self.syncAllDataOnLogin(context: context)
                }
            } else {
                print("No user logged in or user signed out. Clearing active sync queue.")
            }
        }
    }



}
