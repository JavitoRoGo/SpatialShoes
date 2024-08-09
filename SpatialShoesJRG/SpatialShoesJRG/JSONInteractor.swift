//
//  JSONInteractor.swift
//  SpatialShoesJRG
//
//  Created by Javier Rodríguez Gómez on 7/8/24.
//

import Foundation

protocol JSONInteractor {}

extension JSONInteractor {
	func loadJSON<JSON>(url: URL, type: JSON.Type) throws -> JSON where JSON: Codable {
		let data = try Data(contentsOf: url)
		return try JSONDecoder().decode(type, from: data)
	}
	
	func saveJSON<JSON>(datas: JSON, url: URL) throws where JSON: Codable {
		let data = try JSONEncoder().encode(datas)
		try data.write(to: url, options: .atomic)
	}
}
