//
//  RotateModelVM.swift
//  SpatialShoesJRG
//
//  Created by Javier Rodríguez Gómez on 10/8/24.
//

import SwiftUI

@Observable
final class RotateModelVM {
	var rotate = true
	var touch = false
	var rotationAngle = 0.0
	var currentHRotation: CGFloat = 0.0
	var currentVRotation: CGFloat = 0.0
	var lastHorizontalDragValue: CGFloat = 0.0
	var lastVerticalDragValue: CGFloat = 0.0
	var velocityH: CGFloat = 0.0
	var velocityV: CGFloat = 0.0
	
	func applyScaleToShoe(_ shoe: Shoe) -> Bool {
		shoe.model3DName == "AirSportShoe" ||
		shoe.model3DName == "NBSportShoes" ||
		shoe.model3DName == "BlueVansShoe" ||
		shoe.model3DName == "CanvasShoe" ||
		shoe.model3DName == "CanguroShoes"
	}
	
	func startRotation() {
		let timer = Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { _ in
			if self.rotate {
				if self.rotationAngle < 360 {
					self.rotationAngle += 1.2
				} else {
					self.rotationAngle = 0
				}
			}
		}
		RunLoop.current.add(timer, forMode: .common)
	}
	
	func touchingModel(value: DragGesture.Value) {
		let deltaH = value.translation.width - lastHorizontalDragValue
		let deltaV = value.translation.height - lastVerticalDragValue
		velocityH = deltaH / 5
		velocityV = deltaV / 5
		lastHorizontalDragValue = value.translation.width
		lastVerticalDragValue = value.translation.height
		if touch {
			currentHRotation += velocityH
			currentVRotation -= velocityV
		}
	}
}
