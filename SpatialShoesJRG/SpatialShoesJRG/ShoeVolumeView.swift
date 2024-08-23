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
	let shoe: Shoe = .preview
	
	var body: some View {
		List(vm.shoes) { shoe in
			Model3D(named: shoe.model3DName, bundle: shoes3DBundle) { model in
				model
					.resizable()
					.scaledToFit()
//					.frame(depth: 400)
//					.frame(width: 400, height: 400)
			} placeholder: {
				ProgressView()
			}
		}
	}
}

#Preview(windowStyle: .volumetric) {
	ShoeVolumeView()
		.environment(ShoesVM(interactor: TestInteractor()))
}
