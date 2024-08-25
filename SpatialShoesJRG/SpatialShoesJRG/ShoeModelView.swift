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
			Model3D(named: shoe.model3DName, bundle: shoes3DBundle) { model in
				model
					.resizable()
					.scaledToFit()
					.frame(depth: 300)
					.frame(width: 300, height: 300)
					.scaleEffect(
						rotateVM.applyScaleToShoe(shoe) ? 0.4 : 1.0
					)
			} placeholder: {
				ProgressView()
			}
			.onTapGesture {
				if !vm.showingDetail {
					vm.showingDetail = true
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
