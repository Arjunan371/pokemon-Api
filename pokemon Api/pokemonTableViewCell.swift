

import UIKit

class pokemonTableViewCell: UITableViewCell {
    var viewModel: PokemonViewModel?
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var name: UILabel!
    
    var createImageModel: [PokemonImageArray] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collection.register(UINib(nibName: "PokemonCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PokemonCollectionViewCell")
        collection.delegate = self
        collection.dataSource = self
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        print("........subviewLayout")
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
//MARK: COLLECTIONVIEWCELL
extension pokemonTableViewCell:  UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("===============>",viewModel?.filteredPokemonList.count ?? 0)
        return createImageModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let pokemonImaeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonCollectionViewCell", for: indexPath) as! PokemonCollectionViewCell
        let cellObj = createImageModel[indexPath.row]
        
        pokemonImaeCell.pokemonImage?.sd_setImage(with: URL(string: cellObj.image ?? ""), placeholderImage: UIImage(systemName: "person.fill"))
        //        pokemonImaeCell.pokemonImage?.sd_setImage(with: URL(string: cellObj?.image ?? ""), placeholderImage: UIImage(systemName: "person.fill") )
        return pokemonImaeCell
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let imgWidth = CGRectGetWidth(collectionView.frame)/1.0
        return CGSize(width: imgWidth, height: imgWidth)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func imageArray(responsedata: PokemonModel2){
        createImageModel.removeAll()
        var imageModel = PokemonImageArray()
        imageModel.image = responsedata.sprites?.backDefault ?? ""
        createImageModel.append(imageModel)
        var imageModel1 = PokemonImageArray()
        imageModel1.image = responsedata.sprites?.backShiny ?? ""
        createImageModel.append(imageModel1)
        var imageModel2 = PokemonImageArray()
        imageModel2.image = responsedata.sprites?.frontDefault ?? ""
        createImageModel.append(imageModel2)
        var imageModel3 = PokemonImageArray()
        imageModel3.image = responsedata.sprites?.frontShiny ?? ""
        createImageModel.append(imageModel3)
        print("createImageModel==========>",createImageModel.count)
        collection.reloadData()
    }
    
}
