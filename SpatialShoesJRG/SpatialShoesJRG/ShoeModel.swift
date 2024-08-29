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
	let scale: Float
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
