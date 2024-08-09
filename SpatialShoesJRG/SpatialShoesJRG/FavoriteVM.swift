//
//  FavoriteVM.swift
//  SpatialShoesJRG
//
//  Created by Javier Rodríguez Gómez on 9/8/24.
//

import SwiftUI

@Observable
final class FavoriteVM {
	var isFavorite: Bool = false
	
	func isShoeFavorite(favs: [FavShoe], shoe: Shoe) {
		isFavorite = favs.contains(where: { $0.id == shoe.id })
	}
}
