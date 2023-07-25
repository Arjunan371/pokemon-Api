
import Foundation
import UIKit
class PokemonViewModel: NSObject {
    
//    var pokemonImaeArray: [PokemonImageArray] = []
    var pokemonModels2: [PokemonModel2] = []
    var reloadTableView: (() -> ())?
    var collectionReload: (() -> ())?
  //  var responsedataModel: PokemonModel2?
    // compute variable
    var filteredPokemonList: [PokemonModel2] {
        pokemonModels2.sorted(by: {$0.id < $1.id})
    }
  
    // return function
    //    func  filteredPokemonList() -> [PokemonModel2] {
    //    }
    
    func apiForPokemonModel(){
        let urlString = "https://pokeapi.co/api/v2/pokemon?limit=100&offset=0"
        guard let url = URL(string: urlString) else {
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request){ data, response, error in
            guard error == nil else{ return}
            guard let SDdata = data else {
                print("Error: Did not recieve data")
                return}
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {print("Error: HTTP request failed")
                return
                
            }
            do{
                let responsedata = try JSONDecoder().decode(PokemonModel.self, from: SDdata)
                if let result = responsedata.results {
                    for index in 0..<result.count {
                        self.secondApiForPokemon(url: result[index].url ?? "", completion: {
                            DispatchQueue.main.async {
                                self.reloadTableView?()
                            }
                        })
                    }
                    
                    print("responce======>", result.count)
                    //                    self.counts = result.count
                }
            
            }
            catch{
                print(error)
            }
            
        }.resume()
        print("continue")
    }
    
    func secondApiForPokemon(url: String, completion: @escaping (() -> ())) {
        
        guard let urlString = URL(string: url) else {
            return
        }
        let request = URLRequest(url: urlString)
        URLSession.shared.dataTask(with: request){ data, response, error in
            guard error == nil else{ return}
            guard let SDdata = data else {
                print("Error: Did not recieve data")
                return}
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {print("Error: HTTP request failed")
                return
                
            }
            do{
                
                let responsedata = try JSONDecoder().decode(PokemonModel2.self, from: SDdata)
                self.pokemonModels2.append(responsedata)
                print(responsedata)
          //      self.responsedataModel = responsedata

                completion()
            }
            catch{
                print(error)
            }
            
        }.resume()
        print("continue")
    }
    
    

}




