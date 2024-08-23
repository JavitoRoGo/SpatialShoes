//
//  SpatialShoesJRGApp.swift
//  SpatialShoesJRG
//
//  Created by Javier Rodríguez Gómez on 7/8/24.
//

import SwiftUI

@main
struct SpatialShoesJRGApp: App {
	@State private var vm = ShoesVM()
	@State private var favVM = FavoriteVM()
	
    var body: some Scene {
        WindowGroup {
            MainView()
				.environment(vm)
				.environment(favVM)
        }
		
		WindowGroup(id: "shoeDetail") {
			ShoeVolumeView()
				.environment(vm)
		}
		.windowStyle(.volumetric)
		.defaultSize(width: 0.5, height: 0.5, depth: 0.5, in: .meters)
    }
}
