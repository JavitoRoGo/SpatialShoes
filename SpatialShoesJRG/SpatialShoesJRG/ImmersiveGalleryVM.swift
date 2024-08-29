//
//  ImmersiveGalleryVM.swift
//  SpatialShoesJRG
//
//  Created by Javier Rodríguez Gómez on 28/8/24.
//

import SwiftUI
import RealityKit

@Observable
final class ImmersiveGalleryVM {
	let headAnchor = AnchorEntity(.head, trackingMode: .once)
	let diameter: Float = 6.5
	let totalElements = 21
	
	var index = 0
	
	func moveShoe(_ shoe: Entity, pos: Int) throws {
		var transform = shoe.transform
		
		transform.translation = coordinatesForShoe(pos: pos)
		
		let animation = FromToByAnimation(to: transform, duration: 1.0, bindTarget: .transform)
		let view = AnimationView(source: animation)
		
		let animationGroup = AnimationGroup(group: [view])
		shoe.playAnimation(try AnimationResource.generate(with: animationGroup))
	}
	
	func coordinatesForShoe(pos: Int) -> SIMD3<Float> {
		let radius = diameter / 2.0
		
		// Angle between elements
		let angle = (2.0 * .pi) / Float(totalElements)
		
		// Angle based on element index
		let actualAngle = Float(pos) * angle
		
		// (x,z) coordinates using sin and cos
		let x = radius * sin(actualAngle)
		let y = (-radius * cos(actualAngle) + 1.5) * 0.1
		let z = radius * cos(actualAngle) - radius - 1.5
		
		return SIMD3<Float>(x, y, z)
	}
}
