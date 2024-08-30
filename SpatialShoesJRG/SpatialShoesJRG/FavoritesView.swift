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
	@Environment(FavoriteVM.self) private var favVM
	@Environment(\.openWindow) private var openWindow
	@State private var rotateVM = RotateModelVM()
	
	let columns = [GridItem(.adaptive(minimum: 200, maximum: 300))]
	
    var body: some View {
		ScrollView {
			ZStack {
				ContentUnavailableView(
					"Spatial Shoes",
					systemImage: "shoe.fill",
					description: Text("No has marcado ningún artículo como favorito.")
				)
				.opacity(favVM.favorites.isEmpty ? 1.0 : 0.0)
				
				LazyVGrid(columns: columns) {
					ForEach(favVM.favorites) { shoe in
						VStack {
							Shoe3DModelView(shoe: shoe, 
											applyScale: rotateVM.applyScaleToShoe(shoe),
											width: 200, 
											height: 200,
											depth: 200,
											rotationAngle: rotateVM.rotationAngle)
							.onTapGesture {
								favVM.selectedFav = shoe
								if !favVM.showingFavDetail {
									favVM.showingFavDetail = true
									openWindow(id: "favDetail")
								}
							}
							
							VStack {
								Text(shoe.name)
								Button {
									favVM.isFavorite.toggle()
									favVM.toggleFavorite(shoe)
								} label: {
									Image(systemName: "trash")
								}
							}
						}
						.onAppear {
							rotateVM.startRotation()
						}
						.onDisappear {
							rotateVM.stopRotation()
						}
					}
				}
				.opacity(favVM.favorites.isEmpty ? 0.0 : 1.0)
			}
		}
    }
}

#Preview(windowStyle: .automatic) {
    FavoritesView()
		.environment(ShoesVM(interactor: TestInteractor()))
		.environment(FavoriteVM(interactor: TestInteractor()))
}
