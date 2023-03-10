//
//  PokemonModel.swift
//  Pokedex
//
//  Created by macbookair on 07/03/23.
//

import Foundation
import UIKit
import RealmSwift

class Pokemon: Object, Identifiable{
    
    @Persisted var id: Int
    @Persisted var name: String = ""

    @Persisted var image: String = ""
    @Persisted var url: String = ""

    var type = List<TypeName>()

    override static func primaryKey() -> String? {
        return "id"
    }
}

class TypeName: Object, Identifiable{
    @Persisted var typeName: String = ""
    
}
