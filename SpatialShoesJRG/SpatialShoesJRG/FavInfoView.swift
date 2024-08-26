//
//  FavInfoView.swift
//  SpatialShoesJRG
//
//  Created by Javier Rodríguez Gómez on 26/8/24.
//

import SwiftUI

struct FavInfoView: View {
	@Environment(FavoriteVM.self) private var favVM
	
    var body: some View {
		if let shoe = favVM.selectedFav {
			ShoeInfoView(shoe: shoe)
				.onDisappear {
					favVM.showingFavDetail = false
				}
		}
    }
}

#Preview(windowStyle: .automatic) {
    FavInfoView()
		.environment(FavoriteVM(interactor: TestInteractor()))
}
