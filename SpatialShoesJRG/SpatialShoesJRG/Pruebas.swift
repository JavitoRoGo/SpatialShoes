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
		HStack {
			RealityView { content in
				do {
					let scene = try await Entity(named: "Scene", in: shoes3DBundle)
					if let entity = scene.findEntity(named: "leatherShoes") {
						content.add(entity)
						entity.scale = SIMD3<Float>(repeating: 0.00012 / 10)
						entity.position = [0, 0, 0]
					} else {
						print("No encuentra el modelo")
					}
				} catch {
					print(error.localizedDescription)
				}
			} placeholder: {
				ProgressView()
			}
			
			RealityView { content in
				do {
					let scene = try await Entity(named: "Scene", in: shoes3DBundle)
					if let entity = scene.findEntity(named: vm.shoes[2].model3DName) {
						content.add(entity)
						entity.scale = SIMD3<Float>(repeating: vm.shoes[2].scale / 10)
						entity.position = [0, 0, 0]
					} else {
						print("No encuentra el modelo")
					}
				} catch {
					print(error.localizedDescription)
				}
			} placeholder: {
				ProgressView()
			}
		}
    }
}

#Preview(windowStyle: .volumetric) {
    Pruebas()
}
