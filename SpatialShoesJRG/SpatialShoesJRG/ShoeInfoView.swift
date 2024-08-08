//
//  ShoeInfoView.swift
//  SpatialShoesJRG
//
//  Created by Javier Rodríguez Gómez on 8/8/24.
//

import SwiftUI

struct ShoeInfoView: View {
	let selectedShoe: Shoe
	@State private var size = 0
	
    var body: some View {
		VStack {
			Text(selectedShoe.name)
				.font(.largeTitle)
			ScrollView {
				VStack {
					LabeledContent("Marca", value: selectedShoe.brand.rawValue)
					LabeledContent("Tipo", value: selectedShoe.type)
					LabeledContent("Estilo", value: selectedShoe.gender.rawValue)
					LabeledContent("Tallas disponibles") {
						Picker("Tallas", selection: $size) {
							ForEach(selectedShoe.size, id: \.self) { talla in
								Text(talla.formatted())
									.tag(talla)
							}
						}
					}
					LabeledContent("Colores", value: selectedShoe.colorsList)
					LabeledContent("Materiales", value: selectedShoe.materialsList)
					LabeledContent("Precio", value: selectedShoe.price.formatted(.currency(code: "eur")))
				}
				Divider()
					.padding(.vertical, 25)
				LabeledContent("Origen", value: selectedShoe.origin)
					.padding(.bottom)
				Text(selectedShoe.description)
					.font(.caption)
			}
		}
		.padding()
    }
}

#Preview(windowStyle: .automatic) {
	ShoeInfoView(selectedShoe: .preview)
}
