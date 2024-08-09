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
	
    var body: some Scene {
        WindowGroup {
            MainView()
				.environment(vm)
        }
    }
}
