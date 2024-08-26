//
//  ShoeInfoView.swift
//  SpatialShoesJRG
//
//  Created by Javier Rodríguez Gómez on 8/8/24.
//

import SwiftUI

struct ShoeInfoView: View {
	let shoe: Shoe
	let showToggle: Bool
	@Environment(FavoriteVM.self) private var favVM
	@State private var size = 0
	
    var body: some View {
		VStack {
			Text(shoe.name)
				.font(.largeTitle)
			ScrollView {
				VStack {
					LabeledContent("Marca", value: shoe.brand.rawValue)
					LabeledContent("Tipo", value: shoe.type)
					LabeledContent("Estilo", value: shoe.gender.rawValue)
					LabeledContent("Tallas disponibles") {
						Picker("Tallas", selection: $size) {
							ForEach(shoe.size, id: \.self) { talla in
								Text(talla.formatted())
									.tag(talla)
							}
						}
					}
					LabeledContent("Colores", value: shoe.colorsList)
					LabeledContent("Materiales", value: shoe.materialsList)
					LabeledContent("Precio", value: shoe.price.formatted(.currency(code: "eur")))
					HStack {
						Spacer()
						Button {
							favVM.isFavorite.toggle()
							favVM.toggleFavorite(shoe)
						} label: {
							Text(favVM.isFavorite ? "Eliminar de Favoritos" : "Añadir a Favoritos")
						}
					}
					.opacity(showToggle ? 1.0 : 0.0)
				}
				Divider()
					.padding(.vertical, 25)
				LabeledContent("Origen", value: shoe.origin)
					.padding(.bottom)
				Text(shoe.description)
					.font(.caption)
			}
		}
		.padding()
		.onChange(of: shoe, initial: true) {
			favVM.isShoeFavorite(shoe: shoe)
		}
    }
}

#Preview(windowStyle: .automatic) {
	ShoeInfoView(shoe: .preview, showToggle: true)
		.environment(ShoesVM(interactor: TestInteractor()))
		.environment(FavoriteVM(interactor: TestInteractor()))
}
