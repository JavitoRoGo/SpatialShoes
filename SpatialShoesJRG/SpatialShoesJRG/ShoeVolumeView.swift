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
				Shoe3DModelView(shoe: shoe,
								applyScale: rotateVM.applyScaleToShoe(shoe),
								width: 400,
								height: 400,
								depth: 400,
								rotationAngle: rotateVM.rotationAngle,
								currentHRotation: rotateVM.currentHRotation,
								currentVRotation: rotateVM.currentVRotation)
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
				vm.showingVolumeDetail = false
				rotateVM.stopRotation()
			}
		}
	}
}

#Preview(windowStyle: .volumetric) {
	ShoeVolumeView()
		.environment(ShoesVM(interactor: TestInteractor()))
}
