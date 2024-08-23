//
//  MainView.swift
//  SpatialShoesJRG
//
//  Created by Javier Rodríguez Gómez on 7/8/24.
//

import SwiftUI
import RealityKit

struct MainView: View {
	@Environment(ShoesVM.self) private var vm
	var body: some View {
		@Bindable var bvm = vm
		
		TabView {
			GalleryView()
				.tabItem {
					Label("Galería", systemImage: "shoe")
				}
			FavoritesView()
				.tabItem {
					Label("Favoritos", systemImage: "star")
				}
		}
		.alert("UPS!", isPresented: $bvm.initialAlert) {} message: {
			Text(vm.errorMsg)
		}
    }
}

#Preview(windowStyle: .automatic) {
	MainView()
		.environment(ShoesVM(interactor: TestInteractor()))
		.environment(FavoriteVM())
}
