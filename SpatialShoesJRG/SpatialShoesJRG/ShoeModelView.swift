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
	@Environment(\.openWindow) private var openWindow
	@Environment(ShoesVM.self) private var vm
	
	@State private var rotateVM = RotateModelVM()
	
    var body: some View {
		VStack {
			Shoe3DModelView(shoe: shoe, applyScale: rotateVM.applyScaleToShoe(shoe))
			.onTapGesture {
				if !vm.showingVolumeDetail {
					vm.showingVolumeDetail = true
					openWindow(id: "shoeDetail")
				}
			}
			
			Text("Pulsa sobre el modelo para verlo en más detalle.")
				.padding(.top, 40)
		}
    }
}

#Preview(windowStyle: .automatic) {
	ShoeModelView(shoe: .preview)
		.environment(ShoesVM(interactor: TestInteractor()))
}
