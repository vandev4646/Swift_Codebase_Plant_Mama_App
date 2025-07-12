//
//  SegmentView.swift
//  PlantMama
//
//  Created by Vanessa Bennett on 6/16/25.
//

import SwiftUI

enum SegmentSelection: String, CaseIterable {
    case photos = "Photos"
    case reminders = "Reminders"
}


struct SegmentView: View {
    @State private var selection: SegmentSelection = .photos
    @Namespace private var animation
    @Binding var plant: Plant
    
    var body: some View {
        
        VStack{
            HStack{
                ForEach(SegmentSelection.allCases, id: \.rawValue) { segment in
                    Text(segment.rawValue)
                        .padding(.vertical, 10)
                        .frame(width: 100)
                        .foregroundStyle( selection == segment ? .white : .primary)
                        .bold(selection == segment)
                        .background(
                            ZStack{
                                if selection == segment {
                                    Capsule()
                                        .foregroundStyle(.themePink.gradient)
                                        .matchedGeometryEffect(id: "selection", in: animation)
                                }
                            }
                                .animation(.bouncy, value: selection)
                        )
                        .contentShape(.rect)
                        .onTapGesture {
                            selection = segment
                        }
                }
            }
            .padding(5)
            .background(.primary.opacity(0.06), in: .capsule)
            .padding(.top)
            
            if selection == .photos {
                PhotoRow(plant: plant)
            }
            else {
                ReminderRow(plant: $plant)
            }
        }
    }
}
