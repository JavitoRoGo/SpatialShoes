//
//  DataTest.swift
//  SpatialShoesJRG
//
//  Created by Javier Rodríguez Gómez on 7/8/24.
//

import Foundation

struct TestInteractor: DataInteractor {
	var url: URL = Bundle.main.url(forResource: "shoesTest", withExtension: "json")!
	var favURL: URL = Bundle.main.url(forResource: "shoesTest", withExtension: "json")!
	
	func getFavorites() throws -> [Shoe] {
		try loadJSON(url: favURL, type: [Shoe].self)
	}
}

extension Shoe {
	static let preview = Shoe(
		id: 10345,
		name: "Sporty Chic",
		brand: Brand(rawValue: "EleganceWalk")!,
		size: [36,37,38,39,40],
		price: 89.99,
		description: "Descubre el estilo y la comodidad con nuestras **Sporty Chic** de **EleganceWalk**. Diseñadas para las mujeres activas que no quieren sacrificar el estilo por la funcionalidad, estas zapatillas deportivas femeninas ofrecen una combinación perfecta de rendimiento y elegancia. Ideales para actividades deportivas y para el uso diario.\n\n**Características Destacadas:**\n- **Material:** Tejidos y materiales sintéticos de alta calidad que garantizan transpirabilidad y durabilidad.\n- **Diseño:** Estilo moderno y femenino que se adapta a cualquier atuendo deportivo.\n- **Comodidad:** Suela ergonómica y plantilla acolchada para un confort superior en cada paso.\n- **Versatilidad:** Perfectas para correr, entrenar o simplemente para un look deportivo casual, disponibles en varias tallas.\n\nRealza tu rendimiento y tu estilo con nuestras **Sporty Chic** y marca la diferencia en cada paso.",
		model3DName: "fashionSportShoe",
		scale: 0.08,
		type: "Deportivas",
		materials: ["Sintético","Textil"],
		origin: "Estados Unidos",
		gender: .init(rawValue: "Unisex")!,
		weight: 0.8,
		colors: [
			.init(rawValue: "Rojo")!,
			.init(rawValue: "Blanco")!,
			.init(rawValue: "Negro")!
		],
		warranty: 2,
		certifications: ["Materiales Reciclados","Libre de Crueldad"]
	)
}
