//
//  ShoeModelView.swift
//  SpatialShoesJRG
//
//  Created by Javier Rodríguez Gómez on 9/8/24.
//

import SwiftUI
import RealityKit
import Shoes3D

struct ShoeModelView: View {
	let shoe: Shoe
	@State private var rotateVM = RotateModelVM()
	@Binding var rotate: Bool
	@Binding var touch: Bool
	
    var body: some View {
		Model3D(named: shoe.model3DName, bundle: shoes3DBundle) { model in
			model
				.resizable()
				.scaledToFit()
				.frame(depth: 400)
				.frame(width: 400, height: 400)
				.scaleEffect(
					rotateVM.applyScaleToShoe(shoe) ? 0.4 : 1.0
				)
				.offset(y: 50)
				.rotation3DEffect(.degrees(rotateVM.rotationAngle), axis: (0,1,0), anchor: .center)
				.rotation3DEffect(.degrees(Double(rotateVM.currentHRotation)), axis: (0,1,0))
				.rotation3DEffect(.degrees(Double(rotateVM.currentVRotation)), axis: (1,0,0))
		} placeholder: {
			ProgressView()
		}
		.gesture(
			DragGesture()
				.onChanged { value in
					rotateVM.touchingModel(value: value)
				}
				.onEnded { _ in
					rotateVM.lastHorizontalDragValue = 0.0
					rotateVM.lastVerticalDragValue = 0.0
				}
		)
		.onAppear {
			rotateVM.startRotation()
		}
		.onChange(of: rotate) {
			rotateVM.rotate = rotate
		}
		.onChange(of: touch) {
			rotateVM.touch = touch
		}
    }
}

#Preview(windowStyle: .automatic) {
	@Previewable @State var rotate = false
	@Previewable @State var touch = true
	ShoeModelView(shoe: .preview, rotate: $rotate, touch: $touch)
}
