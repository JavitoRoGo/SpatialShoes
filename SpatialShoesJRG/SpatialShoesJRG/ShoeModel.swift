//
//  ShoeModel.swift
//  SpatialShoesJRG
//
//  Created by Javier Rodríguez Gómez on 7/8/24.
//

import Foundation

struct Shoe: Codable, Identifiable, Hashable {
	let id: Int
	let name: String
	let brand: Brand
	let size: [Int]
	let price: Double
	let description: String
	let model3DName: String
	let type: String
	let materials: [String]
	let origin: String
	let gender: Gender
	let weight: Double
	let colors: [Colors]
	let warranty: Int
	let certifications: [String]
}

extension Shoe {
	var materialsList: String {
		materials.formatted(.list(type: .and).locale(Locale(identifier: "es-ES")))
	}
	var colorsList: String {
		colors.map {
			$0.rawValue
		}
		.formatted(.list(type: .and).locale(Locale(identifier: "es-ES")))
	}
	
	func toFav(isFav: Bool = false) -> FavShoe {
		FavShoe(
			id: id,
			name: name,
			brand: brand,
			size: size,
			price: price,
			description: description,
			model3DName: model3DName,
			type: type,
			materials: materialsList,
			origin: origin,
			gender: gender,
			weight: weight,
			colors: colorsList,
			warranty: warranty,
			certifications: certifications,
			isFavorite: isFav
		)
	}
}

enum Brand: String, Codable {
	case athelica = "Athletica"
	case eleganceWalk = "EleganceWalk"
	case gentlemenStyle = "GentlemenStyle"
	case urbanStride = "UrbanStride"
}

enum Colors: String, Codable {
	case blanco = "Blanco"
	case marrón = "Marrón"
	case negro = "Negro"
	case rojo = "Rojo"
}

enum Gender: String, Codable {
	case femenino = "Femenino"
	case masculino = "Masculino"
	case unisex = "Unisex"
}
