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
	var favorites: [FavShoe] = [] {
		didSet {
			saveFavorites()
		}
	}
	var selectedShoe: Shoe?
	
	var initialAlert = false
	@ObservationIgnored var errorMsg = ""
	
	init(interactor: DataInteractor = ShoeInteractor()) {
		self.interactor = interactor
		do {
			let data = try interactor.getData()
			shoes = data
			let fav = try interactor.getFavorites()
			favorites = fav
		} catch {
			shoes = []
			initialAlert = true
			errorMsg = "Hubo un problema con los datos\nPor favor, inténtalo de nuevo más tarde."
		}
	}
	
	func saveFavorites() {
		do {
			try interactor.saveFavorites(favorites)
		} catch {
			initialAlert = true
			errorMsg = "Hubo un problema con los datos\nPor favor, inténtalo de nuevo más tarde."
		}
	}
	
	func toggleFavorite(_ shoe: Shoe) {
		if let index = favorites.firstIndex(where: { $0.id == shoe.id }) {
			// Remove from favorites
			favorites.remove(at: index)
		} else {
			// Add to favorites
			let newFav = shoe.toFav(isFav: true)
			favorites.append(newFav)
		}
	}
}
