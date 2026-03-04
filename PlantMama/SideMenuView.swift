//
//  SideMenuView.swift
//  PlantMama
//
//  Created by Vanessa Bennett on 1/21/26.
//
// Inspiration taken from this article: https://medium.com/geekculture/side-menu-in-ios-swiftui-9fe1b69fc487

import SwiftUI

enum SideMenuRowType: Int, CaseIterable {
    case home = 0
    case addlant
    case allReminders
    
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .addlant:
            return "Add New Plant"
        case .allReminders:
            return "All Reminders"
        }
    }
    
    var iconName: String {
        switch self {
        case .home:
            return "home"
        case .addlant:
            return "plus"
        case .allReminders:
            return "bell"
        }
    }
    
    
}



struct SideMenuView: View {
    
    @Binding var selectedSideMenuTab: Int
    @Binding var presentSideMenu: Bool
    
    var body: some View {
        HStack {
            
            ZStack{
                Rectangle()
                    .fill(.dotCard)
                    .frame(width: 270)
                    .shadow(color: .themePink.opacity(0.1), radius: 5, x: 0, y: 3)
                
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(SideMenuRowType.allCases, id: \.self){ row in
                        RowView(isSelected: selectedSideMenuTab == row.rawValue, imageName: row.iconName, title: row.title) {
                            selectedSideMenuTab = row.rawValue
                            presentSideMenu.toggle()
                        }
                    }
                    
                    Spacer()
                }
                .padding(.top, 100)
                .frame(width: 270)
                .background(
                    Color.dotCard
                )
            }
            
            
            Spacer()
        }
        .background(.clear)
    }
    
    func RowView(isSelected: Bool, imageName: String, title: String, hideDivider: Bool = false, action: @escaping (()->())) -> some View{
        Button{
            action()
        } label: {
            VStack(alignment: .leading){
                HStack(spacing: 20){
                    Rectangle()
                        .fill(isSelected ? .themePink : .dotCard)
                        .frame(width: 5)
                    
                    ZStack{
                        Image(imageName)
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(isSelected ? .black : .gray)
                            .frame(width: 26, height: 26)
                    }
                    .frame(width: 30, height: 30)
                    Text(title)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(isSelected ? .black : .gray)
                    Spacer()
                }
            }
        }
        .frame(height: 50)
        .background(
            LinearGradient(colors: [isSelected ? .themePink.opacity(0.5) : .dotCard, .dotCard], startPoint: .leading, endPoint: .trailing)
        )
    }

    
}
