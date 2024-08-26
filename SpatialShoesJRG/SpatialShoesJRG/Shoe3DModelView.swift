//
//  Shoe3DModelView.swift
//  SpatialShoesJRG
//
//  Created by Javier Rodríguez Gómez on 26/8/24.
//

import SwiftUI
import RealityKit
import Shoes3D

struct Shoe3DModelView: View {
	let shoe: Shoe
	let applyScale: Bool
	var width: CGFloat = 300
	var height: CGFloat = 300
	var depth: CGFloat = 300
	var rotationAngle: Double = 0.0
	var currentHRotation: CGFloat = 0.0
	var currentVRotation: CGFloat = 0.0
	
    var body: some View {
		Model3D(named: shoe.model3DName, bundle: shoes3DBundle) { model in
			model
				.resizable()
				.scaledToFit()
				.frame(depth: depth)
				.frame(width: width, height: height)
				.scaleEffect(
					applyScale ? 0.4 : 1.0
				)
				.offset(y: 50)
				.rotation3DEffect(.degrees(rotationAngle), axis: (0,1,0), anchor: .center)
				.rotation3DEffect(.degrees(Double(currentHRotation)), axis: (0,1,0))
				.rotation3DEffect(.degrees(Double(currentVRotation)), axis: (1,0,0))
		} placeholder: {
			ProgressView()
		}
    }
}

#Preview {
	Shoe3DModelView(shoe: .preview, applyScale: false)
}
