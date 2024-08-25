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
	
	let columns = [GridItem(.adaptive(minimum: 200, maximum: 300))]
	
    var body: some View {
		@Bindable var bvm = vm
		
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
						/*
						RealityView { content, attachment in
							do {
								let scene = try await Entity(named: "Scene", in: shoes3DBundle)
								
								if let entity = scene.findEntity(named: shoe.model3DName),
								   let info = attachment.entity(for: "info") {
									entity.scale = [0.0001, 0.0001, 0.0001]
									info.setPosition([0, -0.1, 0], relativeTo: entity)
									entity.addChild(info, preservingWorldTransform: true)
									content.add(entity)
								}
							} catch {
								bvm.initialAlert = true
							}
						} placeholder: {
							ProgressView()
						} attachments: {
							Attachment(id: "info") {
								VStack {
									Text(shoe.name)
									Button(role: .destructive) {
										favVM.isFavorite.toggle()
										vm.toggleFavorite(shoe)
									} label: {
										Image(systemName: "trash")
									}
								}
							}
						}
						 */
						VStack {
							Model3D(named: shoe.model3DName, bundle: shoes3DBundle) { model in
								model
									.resizable()
									.scaledToFit()
									.frame(depth: 200)
									.frame(height: 200)
									.scaleEffect(
										rotateVM.applyScaleToShoe(shoe) ? 0.4 : 1.0
									)
									.offset(y: 50)
									.rotation3DEffect(.degrees(rotateVM.rotationAngle), axis: (0,1,0), anchor: .center)
							} placeholder: {
								ProgressView()
							}
							
							VStack {
								Text(shoe.name)
								Button {
									favVM.isFavorite.toggle()
									vm.toggleFavorite(shoe)
									Task {
										try? await Task.sleep(nanoseconds: 1000000)
										rotateVM.rotate = true
									}
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
				.opacity(vm.favorites.isEmpty ? 0.0 : 1.0)
			}
		}
    }
}

#Preview(windowStyle: .automatic) {
    FavoritesView()
		.environment(ShoesVM(interactor: TestInteractor()))
		.environment(FavoriteVM())
}
