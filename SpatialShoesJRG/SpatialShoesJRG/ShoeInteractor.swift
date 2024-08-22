//
//  ShoeInteractor.swift
//  SpatialShoesJRG
//
//  Created by Javier Rodríguez Gómez on 7/8/24.
//

import Foundation

protocol DataInteractor: JSONInteractor {
	var url: URL { get }
	var favURL: URL { get }
	func getData() throws -> [Shoe]
	func getFavorites() throws -> [Shoe]
	func saveFavorites(_ shoes: [Shoe]) throws
}

extension DataInteractor {
	var url: URL { Bundle.main.url(forResource: "shoes", withExtension: "json")! }
	var favURL: URL {
		URL.documentsDirectory.appendingPathExtension("shoesFav.json")
	}
	
	func getData() throws -> [Shoe] {
		try loadJSON(url: url, type: [Shoe].self)
	}
	
	func getFavorites() throws -> [Shoe] {
		return if FileManager.default.fileExists(atPath: favURL.path) {
			try loadJSON(url: favURL, type: [Shoe].self)
		} else {
			[]
		}
	}
	
	func saveFavorites(_ shoes: [Shoe]) throws {
		try saveJSON(datas: shoes, url: favURL)
	}
}

struct ShoeInteractor: DataInteractor { }
