
import Foundation
import UIKit

struct PokemonModel: Codable {
    let count:Int?
    let results: [PokemonDatum]?
}
struct PokemonDatum: Codable {
    let url: String?
    let name:String?
}


struct PokemonModel2: Codable{
    let id:Int
    let name: String?
    let height:Int?
    let weight:Int?
    var sprites: Sprites?
}
struct Sprites: Codable {
    let backDefault:String?
    let backShiny: String?
    let frontDefault:String?
    let frontShiny: String?
    var collectionImaegs:[PokemonImageArray]?
    
    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backShiny = "back_shiny"
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
    }
  
}
struct PokemonImageArray {
    var image: String?
}



