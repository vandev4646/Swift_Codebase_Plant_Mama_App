//
//  ThemeViews.swift
//  PlantMama
//
//  Created by Vanessa Bennett on 5/9/25.
//

import SwiftUI

struct FontStyle: ViewModifier {
    var size: CGFloat
    func body(content: Content) -> some View {
        content
            .font(.system(size: size, weight: .medium, design: .rounded))
            .foregroundColor(.brown)
    }
}


struct BackgroundStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .scaledToFill()
            .ignoresSafeArea()
    }
}


struct ListRowStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
    }
}

struct EntryListStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .scrollContentBackground(.hidden)
            .listStyle(.plain)
            //.navigationTitle("Journal")
            .navigationBarTitleDisplayMode(.inline)
            //.toolbar(.hidden)
    }
}

struct EntryBannerStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(height: 80)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .background(CardBackground())
    }
}

struct CardBackground: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .foregroundColor(Color.dotCard)
            .shadow(color: Color.shadow, radius: 4)
    }
}

struct PinkCardBackground: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .foregroundColor(Color.themePink)
            .shadow(color: Color.shadow, radius: 4)
            .frame(width: 30)
    }
}

struct DotThemeView: View {
    var body: some View {
        HStack {
            VStack{
                ZStack {
                    Image(systemName: "leaf.fill")
                        .frame(width: 25)
                        .foregroundColor(.dotGreen)
                        .offset(x: -5, y: -5)
                    Image(systemName: "leaf")
                        .frame(width: 15)
                        .foregroundColor(.dotBrown)
                        .offset(x: 5, y: 5)
                }
                ZStack {
                    Image(systemName: "leaf.fill")
                        .frame(width: 25)
                        .foregroundColor(.dotGreen)
                        .offset(x: 5, y: 5)
                    Image(systemName: "leaf")
                        .frame(width: 20)
                        .foregroundColor(.dotYellow)
                        .offset(x: -5, y: -5)
                }
            }
            Spacer()
            VStack {
                ZStack {
                    Circle()
                        .frame(width: 40)
                        .foregroundColor(.dotGreen)
                        .offset(x: 5, y: 12)
                    Circle()
                        .frame(width: 30)
                        .foregroundColor(.dotBrown)
                        .offset(x: 7, y: -3)
                    Circle()
                        .frame(width: 18)
                        .foregroundColor(.dotYellow)
                        .offset(x: 2, y: -20)
                }
            }
        }
    }
}

