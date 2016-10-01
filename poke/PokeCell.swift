//
//  PokeCell.swift
//  poke
//
//  Created by Abdulaziz  Almohsen on 9/28/16.
//  Copyright © 2016 Abdulaziz. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    // what's inside the cell
    
    @IBOutlet weak var ThumImage : UIImageView!
    @IBOutlet weak var PokeLable : UILabel!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 4.0
    }
    
    var pokemon : Pokemon!
    
    func ConfigureCell (_ pokemon : Pokemon){
        
        self.pokemon = pokemon
        
        // the image is found and set from the assets folder.
        ThumImage.image = UIImage(named: "\(pokemon.pokedex)")
        PokeLable.text = pokemon.name
    }

    
}
