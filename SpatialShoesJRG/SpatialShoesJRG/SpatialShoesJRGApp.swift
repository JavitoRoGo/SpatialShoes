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
	
	@State private var immersiveStyle: ImmersionStyle = .mixed
	
    var body: some Scene {
		WindowGroup(id: "mainView") {
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
		
		WindowGroup(id: "favDetail") {
			FavInfoView()
				.environment(favVM)
		}
		.windowStyle(.automatic)
		.defaultSize(width: 600, height: 500)
		
		ImmersiveSpace(id: "immersive") {
			ImmersiveGalleryView()
				.environment(vm)
		}
		.immersionStyle(selection: $immersiveStyle, in: .mixed, .progressive, .full)
    }
}
