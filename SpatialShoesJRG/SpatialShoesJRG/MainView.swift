//
//  MainView.swift
//  SpatialShoesJRG
//
//  Created by Javier Rodríguez Gómez on 7/8/24.
//

import SwiftUI
import RealityKit

struct MainView: View {
	@State var vm = ShoesVM()
	
    var body: some View {
		NavigationSplitView {
			List(selection: $vm.selectedShoe) {
				Button("Ver todos los modelos") {
					vm.selectedShoe = nil
				}
				ForEach(vm.shoes) { shoe in
					Text(shoe.name)
						.tag(shoe)
				}
			}
			.navigationTitle("Bienvenido a **¡Spatial Shoes!**")
		} content: {
			Group {
				if let selectedShoe = vm.selectedShoe {
					ShoeInfoView(selectedShoe: selectedShoe)
				} else {
					ContentUnavailableView(
						"Spatial Shoes",
						systemImage: "shoe.fill",
						description: Text("Selecciona un artículo de la lista para ver su información."))
				}
			}
		} detail: {
			Image(systemName: "shoe")
				.symbolVariant(.fill)
				.opacity(vm.selectedShoe == nil ? 0 : 1)
		}
		.alert("UPS!", isPresented: $vm.initialAlert) {	} message: {
			Text(vm.errorMsg)
		}
    }
}

#Preview(windowStyle: .automatic) {
	MainView(vm: ShoesVM(interactor: TestInteractor()))
}
