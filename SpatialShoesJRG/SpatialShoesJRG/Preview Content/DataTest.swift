//
//  DataTest.swift
//  SpatialShoesJRG
//
//  Created by Javier Rodríguez Gómez on 7/8/24.
//

import Foundation

struct TestInteractor: DataInteractor {
	var url: URL = Bundle.main.url(forResource: "shoesTest", withExtension: "json")!
}
