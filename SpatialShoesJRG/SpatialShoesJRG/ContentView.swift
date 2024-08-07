//
//  ContentView.swift
//  SpatialShoesJRG
//
//  Created by Javier Rodríguez Gómez on 7/8/24.
//

import SwiftUI
import RealityKit

struct ContentView: View {
	@State var vm = ShoesVM()
	
    var body: some View {
		NavigationSplitView {
			List(selection: $vm.selectedShoe) {
				ForEach(vm.shoes) { shoe in
					Text(shoe.name)
				}
			}
			.navigationTitle("Bienvenido a **Spatial Shoes**")
		} content: {
			if let selectedShoe = vm.selectedShoe {
				
			} else {
				ContentUnavailableView(
					"Spatial Shoes",
					systemImage: "shoe.fill",
					description: Text("Selecciona un artículo de la lista para ver su información."))
			}
		} detail: {
			Image(systemName: "shoe")
				.symbolVariant(.fill)
		}
		.alert("UPS!", isPresented: $vm.initialAlert) {	} message: {
			Text(vm.errorMsg)
		}
    }
}

#Preview(windowStyle: .automatic) {
	ContentView(vm: ShoesVM(interactor: TestInteractor()))
}
