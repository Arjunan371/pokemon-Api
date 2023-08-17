//
//  PokemonDataViewController.swift
//  pokemon Api
//
//  Created by Mohammed Abdullah on 24/07/23.
//

import UIKit

class PokemonDataViewController: UIViewController {
    var id : String?
    var viewModel: PokemonViewModel?
    
    @IBOutlet weak var segmentOne: UISegmentedControl!
    @IBOutlet weak var pokemonWeight: UILabel!
    @IBOutlet weak var pokemonHeight: UILabel!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonId: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var sementTwo: UISegmentedControl!
    var name: String?
    var height: String?
    var weiht: String?
    var image: String?
    var frontDefault:String?
    var frontShiny: String?
    var backDefault: String?
    var backShiny: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        pokemonId.text = id
        pokemonName.text = name
        pokemonHeight.text = height
        pokemonWeight.text = weiht
        pokemonImage.sd_setImage(with: URL(string: image ?? "" ), placeholderImage: UIImage(systemName: "person.fill"))
        //    forSegmentControl()
        
    }
    @IBAction func sementAction(_ sender: UISegmentedControl) {
        forSegmentControl()
    }
    func forSegmentControl(){
        
        if segmentOne.selectedSegmentIndex == 0 && sementTwo.selectedSegmentIndex == 0{
            pokemonImage.image = nil
            pokemonImage.sd_setImage(with: URL(string: frontDefault ?? "" ), placeholderImage: UIImage(systemName: "person.fill"))
        } else if segmentOne.selectedSegmentIndex == 0 && sementTwo.selectedSegmentIndex == 1 {
            pokemonImage.image = nil
            pokemonImage.sd_setImage(with: URL(string: frontShiny ?? "" ), placeholderImage: UIImage(systemName: "person.fill"))
        } else if segmentOne.selectedSegmentIndex == 1 && sementTwo.selectedSegmentIndex == 0 {
            pokemonImage.image = nil
            pokemonImage.sd_setImage(with: URL(string: backDefault ?? "" ), placeholderImage: UIImage(systemName: "person.fill"))
        } else if segmentOne.selectedSegmentIndex == 1 && sementTwo.selectedSegmentIndex == 1 {
            pokemonImage.image = nil
            pokemonImage.sd_setImage(with: URL(string: backShiny ?? "" ), placeholderImage: UIImage(systemName: "person.fill"))
        }
    }
    
}
