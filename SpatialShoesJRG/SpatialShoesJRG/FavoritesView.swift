//
//  FavoritesView.swift
//  SpatialShoesJRG
//
//  Created by Javier Rodríguez Gómez on 9/8/24.
//

import SwiftUI
import RealityKit
import Shoes3D

struct FavoritesView: View {
	@Environment(ShoesVM.self) private var vm
	@Environment(FavoriteVM.self) private var favVM
	@State private var rotateVM = RotateModelVM()
	
	let columns = [GridItem(.adaptive(minimum: 200, maximum: 400))]
	
    var body: some View {
		ScrollView {
			ZStack {
				ContentUnavailableView(
					"Spatial Shoes",
					systemImage: "shoe.fill",
					description: Text("No has marcado ningún artículo como favorito.")
				)
				.opacity(vm.favorites.isEmpty ? 1.0 : 0.0)
				
				LazyVGrid(columns: columns) {
					ForEach(vm.favorites) { shoe in
						VStack {
							Model3D(named: shoe.model3DName, bundle: shoes3DBundle) { model in
								model
									.resizable()
									.scaledToFit()
									.frame(depth: 300)
									.frame(width: 300, height: 300)
									.scaleEffect(
										rotateVM.applyScaleToShoe(shoe) ? 0.1 : 0.7
									)
							} placeholder: {
								ProgressView()
							}
							Text(shoe.name)
							Text(shoe.model3DName)
							Button(role: .destructive) {
								favVM.isFavorite.toggle()
								vm.toggleFavorite(shoe)
							} label: {
								Image(systemName: "trash")
							}
						}
					}
				}
				.opacity(vm.favorites.isEmpty ? 0.0 : 1.0)
			}
		}
    }
}

#Preview(windowStyle: .automatic) {
    FavoritesView()
		.environment(ShoesVM())
		.environment(FavoriteVM())
}
