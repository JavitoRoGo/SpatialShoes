//
//  ShoesVM.swift
//  SpatialShoesJRG
//
//  Created by Javier Rodríguez Gómez on 7/8/24.
//

import SwiftUI

@Observable
final class ShoesVM {
	let interactor: DataInteractor
	
	var shoes: [Shoe]
	var selectedShoe: Shoe?
	
	var initialAlert = false
	@ObservationIgnored var errorMsg = ""
	
	init(interactor: DataInteractor = ShoeInteractor()) {
		self.interactor = interactor
		do {
			let data = try interactor.getData()
			shoes = data
		} catch {
			shoes = []
			initialAlert = true
			errorMsg = "Hubo un problema con los datos\nPor favor, inténtalo de nuevo más tarde."
		}
	}
}
