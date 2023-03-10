//
//  PokemonView.swift
//  Pokedex
//
//  Created by macbookair on 07/03/23.
//

import SwiftUI
import Kingfisher

struct pokemonView: View {
    @ObservedObject var pokemonViewModel: PokemonViewModel
    @State private var selectedPokemon: Pokemon? = nil

    init(){
        pokemonViewModel = PokemonViewModel()
    }
    
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 3), spacing: 16) {
                ForEach(pokemonViewModel.pokemons){pokemon in
                    VStack{
                        Button(action: {
                            self.selectedPokemon = pokemon
                               }) {
                                   ImageView(url: URL(string: pokemon.image)!)
                                       .frame(width: 60, height: 60)

                               }
                        
                        VStack{
                            Text(pokemon.id.description)
                            Text(pokemon.name)
                            ForEach(pokemon.type){type in
                                Text(type.typeName)
                            }
                        }
                    }
                }
            }
            
        }.sheet(item: $selectedPokemon) { pokemon in
            ImageView(url: URL(string: pokemon.image)!)
        }
        .padding(.init(top: 60, leading: 20, bottom: 60, trailing: 20))
    }
}

struct pokemon_Previews: PreviewProvider {
    static var previews: some View {
        pokemonView()
    }
}

struct ImageView: View {
    let url: URL
    
    var body: some View {
        KFImage(url)
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}


