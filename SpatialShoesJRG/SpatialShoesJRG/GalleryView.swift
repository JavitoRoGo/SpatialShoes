//
//  GalleryView.swift
//  SpatialShoesJRG
//
//  Created by Javier Rodríguez Gómez on 9/8/24.
//

import SwiftUI

struct GalleryView: View {
	@Environment(ShoesVM.self) private var vm
	@Environment(\.openImmersiveSpace) private var openImmersive
	@Environment(\.dismissImmersiveSpace) private var dismissImmersive
	
    var body: some View {
		@Bindable var bvm = vm
		
		NavigationSplitView {
			List(selection: $bvm.selectedShoe) {
				ForEach(vm.shoes) { shoe in
					Text(shoe.name)
						.tag(shoe)
				}
			}
			.navigationTitle("Spatial Shoes")
			.toolbar {
				ToolbarItem(placement: .bottomOrnament) {
					Toggle(isOn: $bvm.showingImmersive) {
						Text("Espacio inmersivo")
					}
				}
			}
		} content: {
			if let selectedShoe = vm.selectedShoe {
				ShoeInfoView(shoe: selectedShoe, showToggle: true)
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
		.onChange(of: vm.showingImmersive) {
			Task {
				if vm.showingImmersive {
					await openImmersive(id: "immersive")
				} else {
					await dismissImmersive()
				}
			}
		}
    }
}

#Preview {
	GalleryView()
		.environment(ShoesVM(interactor: TestInteractor()))
		.environment(FavoriteVM())
}
