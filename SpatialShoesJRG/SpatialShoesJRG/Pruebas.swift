//
//  Pruebas.swift
//  SpatialShoesJRG
//
//  Created by Javier Rodríguez Gómez on 20/8/24.
//

import SwiftUI
import RealityKit
import Shoes3D

struct Pruebas: View {
	@State private var vm = ShoesVM()
	
    var body: some View {
		List(vm.shoes) { shoe in
//			Model3D(named: shoe.model3DName, bundle: shoes3DBundle) { model in
//				model
//					.resizable()
//					.scaledToFit()
//					.frame(height: 200)
//					.frame(depth: 200)
//			} placeholder: {
//				ProgressView()
//			}
			
			
			RealityView { content in
				do {
					let scene = try await Entity(named: "Scene", in: shoes3DBundle)
					if let entity = scene.findEntity(named: shoe.model3DName) {
						content.add(entity)
						entity.scale = [0.0002, 0.0002, 0.0002]
					} else {
						print("No encuentra \(shoe.model3DName)")
					}
				} catch {
					
				}
			} placeholder: {
				ProgressView()
			}
		}
    }
}

#Preview(windowStyle: .automatic) {
    Pruebas()
}
