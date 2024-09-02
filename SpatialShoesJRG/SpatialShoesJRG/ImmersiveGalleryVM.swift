//
//  ImmersiveGalleryVM.swift
//  SpatialShoesJRG
//
//  Created by Javier Rodríguez Gómez on 28/8/24.
//

import SwiftUI
import RealityKit
import Shoes3D

@Observable
final class ImmersiveGalleryVM {
	let headAnchor = AnchorEntity(.head, trackingMode: .once)
	let handAnchor = AnchorEntity(.hand(.left, location: .palm), trackingMode: .continuous)
	let content = Entity()
	
	let diameter: Float = 6.5
	let totalElements = 21
	
	
	var index = 0
	var selected: Shoe?
	var showingSelected = false
	@ObservationIgnored var timer: Timer?
	@ObservationIgnored var shoes: [Shoe] = []
	
	func rotateCarrousel(_ entity: Entity, pos: Int) throws {
		var transform = entity.transform
		guard let shoe = shoes.first(where: { $0.model3DName == entity.name }) else { return }
		transform.translation = coordinatesForShoe(shoe, pos: pos)
		
		let animation = FromToByAnimation(to: transform, duration: 1.0, bindTarget: .transform)
		let view = AnimationView(source: animation)
		
		let animationGroup = AnimationGroup(group: [view])
		entity.playAnimation(try AnimationResource.generate(with: animationGroup))
	}
	
	func coordinatesForShoe(_ shoe: Shoe, pos: Int) -> SIMD3<Float> {
		let radius = diameter / 2.0
		
		// Angle between elements
		let angle = (2.0 * .pi) / Float(totalElements)
		
		// Angle based on element index
		let actualAngle = Float(pos) * angle
		
		// (x,z) coordinates using sin and cos
		let x = radius * sin(actualAngle)
		let y = ((-radius * cos(actualAngle) + 1.5) * 0.1) + (shoe.posY / 1000)
		let z = radius * cos(actualAngle) - radius - 1.5 + (shoe.posZ / 1000)
		
		return SIMD3<Float>(x, y, z)
	}
	
	@MainActor func showSelected() async throws {
		guard let selected else { return }
		let entity = try await Entity(named: selected.model3DName, in: shoes3DBundle)
		entity.scale = SIMD3<Float>(repeating: selected.scale / 15)
		entity.components.set(InputTargetComponent())
		entity.generateCollisionShapes(recursive: true)
		entity.setParent(content, preservingWorldTransform: false)
		handAnchor.addChild(content)
		entity.position = [0, 0.05, 0] + [0, selected.posY / 1000, selected.posZ / 1000]
		rotateSelected(content)
	}
	
	func removeSelected() {
		content.children.removeAll()
		selected = nil
		showingSelected = false
		timer?.invalidate()
	}
	
	func rotateSelected(_ entity: Entity) {
		timer?.invalidate()
		timer = Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { _ in
			let angle = (Float.pi * 2) / (10 / 0.03)
			entity.transform.rotation *= simd_quatf(angle: angle, axis: [0, 1, 0])
		}
	}
}
