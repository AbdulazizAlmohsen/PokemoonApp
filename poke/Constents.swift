//
//  Constents.swift
//  poke
//
//  Created by Abdulaziz  Almohsen on 9/29/16.
//  Copyright © 2016 Abdulaziz. All rights reserved.
//

import Foundation
import Alamofire

// storing URLs for global referances 


let URL_BASE = "https://pokeapi.co/"
let URL_PokEMON = "api/v1/pokemon/" // and the number of pokemon PokeID 

// this is because when need to download the pokemons when we hit the second view. not before becuae the app might crush if we download it as we click. the code comes after downloading and after another code done is completion

typealias downloadcomplete = () -> () // this will assign download complete to empty closure / called whenever we want 
