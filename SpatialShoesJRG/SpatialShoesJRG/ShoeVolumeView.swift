//
//  ShoeVolumeView.swift
//  SpatialShoesJRG
//
//  Created by Javier Rodríguez Gómez on 23/8/24.
//

import SwiftUI
import RealityKit
import Shoes3D

struct ShoeVolumeView: View {
	@Environment(ShoesVM.self) private var vm
	@State private var rotateVM = RotateModelVM()
	@State private var rotate = true
	@State private var touch = false
	
	var body: some View {
		if let shoe = vm.selectedShoe {
			VStack {
				Model3D(named: shoe.model3DName, bundle: shoes3DBundle) { model in
					model
						.resizable()
						.scaledToFit()
						.frame(depth: 400)
						.frame(height: 400)
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
				
				HStack {
					Toggle("Expositor", isOn: $rotate)
						.disabled(touch)
					Toggle("Girar en 3D", isOn: $touch)
						.disabled(rotate)
				}
				.toggleStyle(.button)
				.padding(.top, 100)
				.offset(z: 450)
			}
			.onAppear {
				rotateVM.startRotation()
			}
			.onChange(of: rotate) {
				rotateVM.rotate = rotate
			}
			.onChange(of: touch) {
				rotateVM.touch = touch
			}
			.onDisappear {
				vm.showingDetail = false
				rotateVM.stopRotation()
			}
		}
	}
}

#Preview(windowStyle: .volumetric) {
	ShoeVolumeView()
		.environment(ShoesVM(interactor: TestInteractor()))
}
