
import SDWebImage
import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
  
    @IBOutlet weak var pokemonTable: UITableView!
   
    var viewModel = PokemonViewModel()
    var filteredData: [PokemonModel2] = []
    lazy var searchBar1: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search..."
        searchBar.delegate = self
        searchBar.isUserInteractionEnabled = true
        searchBar.showsCancelButton = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        viewModel.apiForPokemonModel()
        //   print(ViewModel)
        searchBar1.delegate = self
       self.pokemonTable.reloadData()
        viewModel.reloadTableView = {
            self.pokemonTable.reloadData()
        }
        pokemonTable.translatesAutoresizingMaskIntoConstraints = false
        setConstraints()
      //  view.addSubview(searchBar)
        pokemonTable.delegate = self
        pokemonTable.dataSource = self
      
        // Do any additional setup after loading the view.
    }
    func setConstraints(){
        view.addSubview(searchBar1)
        
        NSLayoutConstraint.activate([
            searchBar1.topAnchor.constraint(equalTo: view.topAnchor,constant: 60),
            searchBar1.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
            searchBar1.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10),
            searchBar1.heightAnchor.constraint(equalToConstant: 40),
            
            pokemonTable.topAnchor.constraint(equalTo: searchBar1.bottomAnchor,constant: 10),
            pokemonTable.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 0),
            pokemonTable.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: 0),
            pokemonTable.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: 0),
        ])
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return searchBar1.text?.isEmpty ?? false ? viewModel.filteredPokemonList.count : filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemon", for: indexPath) as! pokemonTableViewCell
        let cellobj =  searchBar1.text?.isEmpty ?? false ? viewModel.filteredPokemonList[indexPath.row] : filteredData[indexPath.row]
        cell.viewModel = viewModel
        cell.name.text = "name: \(cellobj.name ?? "")"
        cell.height.text = "Id: \(cellobj.id)"
        cell.weight.text = "Height: \(cellobj.height ?? 0)"
        cell.id.text = "Weiht: \(cellobj.weight ?? 0)"
 
    
        cell.imageArray(responsedata: searchBar1.text?.isEmpty ?? false ? viewModel.filteredPokemonList[indexPath.row] : filteredData[indexPath.row])
      

//        cell.pokemonImage.sd_setImage(with: URL(string: cellobj.sprites?.backDefault ?? "" ), placeholderImage: UIImage(systemName: "person.fill"))
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "pokemon2") as! PokemonDataViewController
        let cellobj = viewModel.filteredPokemonList[indexPath.row]
        vc.viewModel = viewModel
        vc.id = "Id: \(cellobj.id)"
        vc.name = "name: \(cellobj.name ?? "")"
        vc.height = "Height: \(cellobj.height ?? 0)"
        vc.weiht = "Weiht: \(cellobj.weight ?? 0)"
        vc.image = cellobj.sprites?.backDefault ?? ""
        vc.frontDefault = cellobj.sprites?.frontDefault ?? ""
        vc.frontShiny = cellobj.sprites?.frontShiny ?? ""
        vc.backDefault = cellobj.sprites?.backDefault ?? ""
        vc.backShiny = cellobj.sprites?.backShiny ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }


}

extension ViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar1.showsCancelButton = true
        return true
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = viewModel.filteredPokemonList.filter({ element in
            element.name?.lowercased().contains(searchText.lowercased()) == true || "\(element.id)".lowercased().contains(searchText.lowercased()) == true ||
            "\(element.height)".lowercased().contains(searchText.lowercased()) == true ||
            "\(element.weight)".lowercased().contains(searchText.lowercased()) == true
        })
        self.pokemonTable.reloadData()
    }
    
}
