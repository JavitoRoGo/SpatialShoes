//
//  FavShoeModel.swift
//  SpatialShoesJRG
//
//  Created by Javier Rodríguez Gómez on 9/8/24.
//

import Foundation

struct FavShoe: Codable, Identifiable, Hashable {
	let id: Int
	let name: String
	let brand: Brand
	let size: [Int]
	let price: Double
	let description: String
	let model3DName: String
	let type: String
	let materials: String
	let origin: String
	let gender: Gender
	let weight: Double
	let colors: String
	let warranty: Int
	let certifications: [String]
	var isFavorite: Bool
}
