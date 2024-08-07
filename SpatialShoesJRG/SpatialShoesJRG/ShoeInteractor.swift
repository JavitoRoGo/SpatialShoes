//
//  ShoeInteractor.swift
//  SpatialShoesJRG
//
//  Created by Javier Rodríguez Gómez on 7/8/24.
//

import Foundation

protocol DataInteractor: JSONInteractor {
	var url: URL { get }
	func getData() throws -> [Shoe]
}

extension DataInteractor {
	var url: URL { Bundle.main.url(forResource: "shoes", withExtension: "json")! }
	
	func getData() throws -> [Shoe] {
		try loadJSON(url: url, type: [Shoe].self)
	}
}

struct ShoeInteractor: DataInteractor { }
