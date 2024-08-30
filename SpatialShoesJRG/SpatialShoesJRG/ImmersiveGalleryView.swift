//
//  ImmersiveGalleryView.swift
//  SpatialShoesJRG
//
//  Created by Javier Rodríguez Gómez on 26/8/24.
//

import SwiftUI
import RealityKit
import Shoes3D

struct ImmersiveGalleryView: View {
	@Environment(\.openWindow) private var openWindow
	@Environment(\.dismissWindow) private var dismissWindow
	@Environment(ShoesVM.self) private var vm
	@State private var galleryVM = ImmersiveGalleryVM()
	
	var body: some View {
		Group {
			RealityView { content, attachments in
				do {
					if let menu = attachments.entity(for: "menu") {
						galleryVM.headAnchor.addChild(menu)
						menu.name = "menu"
						menu.setPosition([0, -0.3, -1.0], relativeTo: galleryVM.headAnchor)
					}
					
					for (position, shoe) in vm.shoes.enumerated() {
						let entity = try await Entity(named: shoe.model3DName, in: shoes3DBundle)
						entity.scale = SIMD3<Float>(repeating: shoe.scale / 10)
						entity.position = galleryVM.coordinatesForShoe(pos: position)
						entity.setParent(galleryVM.headAnchor, preservingWorldTransform: false)
					}
					content.add(galleryVM.headAnchor)
				} catch {
					print(error.localizedDescription)
				}
			} update: { content, _ in
				if let head = content.entities.first {
					let entities = head.children.filter { entity in
						entity.name != "menu"
					}
					for (pos, entity) in entities.enumerated() {
						try? galleryVM.rotateCarrousel(entity, pos: pos - galleryVM.index)
					}
				}
			} attachments: {
				Attachment(id: "menu") {
					VStack {
						Text(vm.shoes[galleryVM.index].name)
							.font(.largeTitle)
						HStack {
							Button {
								galleryVM.index -= 1
								if galleryVM.index < 0 {
									galleryVM.index = vm.shoes.count - 1
								}
							} label: {
								Image(systemName: "chevron.left")
							}
							Button {
								galleryVM.index += 1
								if galleryVM.index > vm.shoes.count - 1 {
									galleryVM.index = 0
								}
							} label: {
								Image(systemName: "chevron.right")
							}
						}
						.frame(width: 400)
						Button {
							if galleryVM.showingSelected {
								galleryVM.removeSelected()
							} else {
								galleryVM.selected = vm.shoes[galleryVM.index]
								galleryVM.showingSelected = true
								Task { try await galleryVM.showSelected() }
							}
						} label: {
							Text(galleryVM.showingSelected ? "Ocultar modelo" : "Ver modelo")
						}
					}
					.padding()
					.glassBackgroundEffect()
				}
			}
			
			if let _ = galleryVM.selected {
				RealityView { content in
					content.add(galleryVM.handAnchor)
				}
				.gesture(
					SpatialTapGesture().targetedToEntity(galleryVM.content).onEnded { value in
						galleryVM.removeSelected()
					}
				)
			}
		}
		.onAppear {
			dismissWindow(id: "mainView")
			dismissWindow(id: "shoeDetail")
			dismissWindow(id: "favDetail")
		}
		.onDisappear {
			vm.showingImmersive = false
			openWindow(id: "mainView")
		}
	}
}
