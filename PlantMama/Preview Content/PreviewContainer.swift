//
//  PreviewContainer.swift
//  PlantMama
//
//  Created by Vanessa Bennett on 6/24/25.
//

import SwiftData
import SwiftUI

struct PlantSampleData: PreviewModifier {

    static func makeSharedContext() async throws -> ModelContainer {
        let container = try ModelContainer(for: Plant.self, configurations: .init(isStoredInMemoryOnly: true))
        Plant.sampleData.forEach { container.mainContext.insert($0) }
        return container
    }

    func body(content: Content, context: ModelContainer) -> some View {
        content.modelContainer(context)
    }
}

extension PreviewTrait where T == Preview.ViewTraits {
    @MainActor static var plantSampleData: Self = .modifier(PlantSampleData())
}
