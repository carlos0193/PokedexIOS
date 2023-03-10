//
//  PokemonModelView.swift
//  Pokedex
//
//  Created by macbookair on 07/03/23.
//

import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift


class PokemonViewModel: ObservableObject{
    @Published var pokemons = [Pokemon]()
    let realm = try? Realm()
    
    init(){
        getPokemon()
    }
    
    func getPokemon(){
        let url = "https://pokeapi.co/api/v2/pokemon?limit=1281&offset=0"
        AF.request(url, method: .get).responseJSON { response in
                let resultValue = response.result
                do {
                    let value = try JSON(resultValue.get())
                    for result in value["results"].arrayValue {
                        let pokemon = Pokemon()
                        pokemon.name = result["name"].stringValue
                        pokemon.url = result["url"].stringValue
                        
                        self.fetchPokemonDetails(with: pokemon.url) { details in
                            pokemon.id = details["id"].intValue
                            let sprites = details["sprites"]
                            pokemon.image = sprites["front_default"].stringValue
                            
//                            let types = details["types"]
                            for type in details["types"].arrayValue{
                                let typeAux = TypeName()
                                let typeName = type["type"]
                                typeAux.typeName = typeName["name"].stringValue
                                pokemon.type.append(typeAux)
                            }
                            
                            self.pokemons.append(pokemon)
                            print(self.pokemons)
                        }
                    }
                } catch {
                    print(response.error)
                }
            }
    }
    
    func fetchPokemonDetails(with url: String, completion: @escaping (JSON) -> Void) {
        AF.request(url, method: .get).responseJSON { response in
            let resultValue = response.result
            do {
                let value = try JSON(resultValue.get())
                completion(value)
            } catch {
                print(response.error)
            }
        }
    }
}
