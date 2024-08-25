//
//  GalleryView.swift
//  SpatialShoesJRG
//
//  Created by Javier Rodríguez Gómez on 9/8/24.
//

import SwiftUI

struct GalleryView: View {
	@Environment(ShoesVM.self) private var vm
	
    var body: some View {
		@Bindable var bvm = vm
		
		NavigationSplitView {
			List(selection: $bvm.selectedShoe) {
				ForEach(vm.shoes) { shoe in
					Text(shoe.name)
						.tag(shoe)
				}
			}
			.navigationTitle("Bienvenido a ¡Spatial Shoes!")
		} content: {
			if let selectedShoe = vm.selectedShoe {
				ShoeInfoView(shoe: selectedShoe)
			} else {
				ContentUnavailableView(
					"Spatial Shoes",
					systemImage: "shoe.fill",
					description: Text("Selecciona un artículo de la lista para ver su información.")
				)
			}
		} detail: {
			if let selected = vm.selectedShoe {
				ShoeModelView(shoe: selected)
			}
		}
    }
}

#Preview {
	GalleryView()
		.environment(ShoesVM(interactor: TestInteractor()))
		.environment(FavoriteVM())
}
