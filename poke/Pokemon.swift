//
//  Pokemon.swift
//  poke
//
//  Created by Abdulaziz  Almohsen on 9/28/16.
//  Copyright © 2016 Abdulaziz. All rights reserved.
//

import Foundation

import Alamofire


class Pokemon {
    
   fileprivate var _name : String!
   fileprivate var _pokedex : Int!
   fileprivate var _description : String!
   fileprivate var _hight : String!
   fileprivate var _defense : Int!
   fileprivate var _weight : String!
   fileprivate var _attack : Int!
   fileprivate var _evlutionImage :String!
   fileprivate var _type : String!
    private var _EvlutionLable : String!
    private var _level : String?
    
    
    
    
    


    fileprivate var _pokemURL : String!
    
    
    
    var descrption : String {
        
        get {
            if _description == nil {
                 _description = ""
            }
            return _description
        }
    }
    
    
    var defense : Int {
        get {
            if _defense == nil {
                _defense = 0
            }
        
        return _defense
        }
    }
    
    
    
    var height : String {
        get {
            if _hight == nil {
                _hight = ""
            }
        
        return _hight
        }
    }
    
    
    
    var weight : String {
        get {
            if _weight == nil {
                _weight = ""
            }
        
        return _weight
    }
    }
    
    
    
    var attack : Int {
        
        get {
            if _attack == nil {
                _attack = 0
            }
        
        return _attack
    }
    }
    
    
    var evolutionImage : String {
        
        get {
            if _evlutionImage == nil {
                _evlutionImage = ""
            }
        
        return _evlutionImage
    }
    }
    
    
    var evlutionLable : String {
        
        get {
            if _EvlutionLable == nil {
                _EvlutionLable = ""
            
        }
        return _EvlutionLable
    }
    
    }
    
    
    var type : String {
        get {
            if _type == nil {
                _type = ""
            
        }
        return _type
    }
    
    }
    
    var level : String? {
        
        get {
            
            if _level == nil {
                _level = ""
            }
        
        return _level
    }
    }
    
    
    
    var name : String {
      
        return _name
    }
    
    var pokedex : Int {
        
        return _pokedex
    }
    
    init(pokedex : Int , name : String) {
        self._name = name
        self._pokedex = pokedex
        // assign everyone with URL and base to reach the URL request
        _pokemURL = "\(URL_BASE)\(URL_PokEMON)\(pokedex)/" // now we have a link of a pokemon
    }
    
    func downloadImageDetals ( completed : @escaping downloadcomplete){
        let url = URL(string: _pokemURL)
        
            
            // this code make alamofire go to the url and get the Json file. returns dictionary
            
            Alamofire.request(url!).responseJSON { response in
                
                if let dict = response.result.value as? Dictionary< String, Any> {
                    if let attack = dict["attack"] as? Int {
                        self._attack = attack
                    }
                    if let defense = dict["defense"] as? Int {
                        self._defense = defense
                    }
                    if let hight = dict["height"] as? String{
                        self._hight = hight
                    }
                    if let weight = dict["weight"] as? String {
                        self._weight = weight
                    }
                    
                    if let types = dict["types"] as? [Dictionary <String,String>] , types.count > 0 {
                        if let type = types[0]["name"] {
                            self._type = type.capitalized
                        }
                        
                        if types.count > 1 {
                            
                            for x in ( 1 ..< types.count){
                                
                                if let type = types[x]["name"] {
                                    self._type! += "/\(type.capitalized)"
                                    
                                    
                                }
                                
                            }
        
                              
                            }
                            
                    }
       
                     else {
                        self._type = ""
                    }
                    if let descr = dict["descriptions"] as? [Dictionary <String,String> ], descr.count > 0 {
                        
                        if let url =  descr[0]["resource_uri"]{
                            
                            
                            let nsurl = URL(string: "\(URL_BASE)\(url)")
                            
                            Alamofire.request(nsurl!).responseJSON { response in
                                
                                if let dict = response.result.value as? Dictionary <String,Any> {
                                    
                                    if let descriptions = dict["description"] as? String {
                                        self._description = descriptions
                                    }
                                    
                                    
                                    
                                }
                                completed()

                            
                            }
                            
                            if let evlutions = dict["evolutions"] as? [Dictionary <String,Any>] , evlutions.count > 0{
                                if let to = evlutions[0]["to"] as? String {
                                    if to.range(of: "mega") == nil {
                                        self._EvlutionLable = to
                                    } else {
                                        self._EvlutionLable = "No Evlution" // can't support mega
                                        
                                    }
                                }
                                if let uri = evlutions[0]["resource_uri"] as? String{
                                      let new = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                      let number = new.replacingOccurrences(of: "/", with: "")
                                    
                                    self._evlutionImage = "\(number)"
                                }
                                if let lvl = evlutions[0]["level"] as? Int  {
                                    self._level = "\(lvl)"
                                    }
                                
                                
                                
                                print(self._evlutionImage)
                                print(self._EvlutionLable)
                                print(self.level)
                                    
                            }


                        }
                }
        
        
        
                
                
                
                    
                }
            
            
    }
    
}
}
