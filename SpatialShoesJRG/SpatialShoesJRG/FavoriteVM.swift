//
//  FavoriteVM.swift
//  SpatialShoesJRG
//
//  Created by Javier Rodríguez Gómez on 9/8/24.
//

import SwiftUI

@Observable
final class FavoriteVM {
	let interactor: DataInteractor
	
	var favorites: [Shoe] = [] {
		didSet {
			saveFavorites()
		}
	}
	var selectedFav: Shoe?
	var showingFavDetail = false
	var isFavorite = false
	
	var initialAlert = false
	@ObservationIgnored var errorMsg = ""
	
	init(interactor: DataInteractor = ShoeInteractor()) {
		self.interactor = interactor
		do {
			let fav = try interactor.getFavorites()
			favorites = fav
		} catch {
			favorites = []
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
			favorites.append(shoe)
		}
	}
	
	func isShoeFavorite(shoe: Shoe) {
		isFavorite = favorites.contains(where: { $0.id == shoe.id })
	}
}
