//
//  ViewController.swift
//  poke
//
//  Created by Abdulaziz  Almohsen on 9/29/16.
//  Copyright © 2016 Abdulaziz. All rights reserved.
//

import UIKit
import AVFoundation

class MainVC: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var  collectionV : UICollectionView!
    @IBOutlet weak var searchBAR : UISearchBar!
    
    @IBOutlet weak var music: UIButton!
    
    var MusicPlayer : AVAudioPlayer!
    
    
    var pokemon = [Pokemon]()
    var filteredpokemon = [Pokemon]()
    
    var isSreachmode = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionV.delegate = self
        collectionV.dataSource = self
        searchBAR.delegate = self
        
        parsingData()
        AudioIn()
        
    

    
}
    func AudioIn (){
        // set the music and make it loop forever
        
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")
        
        do {
            
            MusicPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path!))
            MusicPlayer.numberOfLoops = -1
            MusicPlayer.prepareToPlay()
            MusicPlayer.play()
        } catch {
            print("no music")
        }
        
        
        
    }
    
    func parsingData (){
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")
        // set a path to the bundle to get the pokecsv file
        
        
        do { // it might throw an error so we need do and catch
            let csv = try CSV(contentsOfURL: path!)
            let rows = csv.rows // set csv file according to the library imported
            for row in rows {
               let pokeName = row["identifier"]
               let pokeID = Int(row["id"]!)
                // add the name and id to to the Pokemon big classs
               let poke =  Pokemon(pokedex: pokeID!, name: pokeName!)
                // add the Pokemon and names to the arry
               pokemon.append(poke)
            }

            
        } catch {
                print("error")
            
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let poke : Pokemon!
        
        if isSreachmode == true {
            
            poke = filteredpokemon[indexPath.row] // if the view is filred then grab the from the filtered pokemons
        } else {
            poke = pokemon[indexPath.row]
        }
        
        
        performSegue(withIdentifier: "PokeDettails", sender: poke)
    }


    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell
        
        let poke : Pokemon!
        
        if isSreachmode == true {
            poke = filteredpokemon[indexPath.row]
        } else {
        poke = pokemon[indexPath.row]
        
    }
        cell?.ConfigureCell(poke)
        return cell!
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSreachmode == true {
            return filteredpokemon.count
        } else {
            return pokemon.count
        }
        
        
        
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
        }
        
        
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            isSreachmode = false
            view.endEditing(true)
            collectionV.reloadData()
        } else{
            isSreachmode = true
            
            let lower = searchBar.text?.lowercased()
            // go to all the elements and give us
            // $0 grab an elemt and gives it 0 name , check the
            filteredpokemon = pokemon.filter({ $0.name.range(of: lower!)  != nil})
            collectionV.reloadData()
            
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)

    }
    
    @IBAction func Musicbutton (_ sender : UIButton?){
        // if music playing then click and stop
       if MusicPlayer.isPlaying{
           MusicPlayer.stop()
        music.alpha = 2
        } else { // stop it anyway
          MusicPlayer.isPlaying
        music.alpha = 1
        }

    
    
}
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokeDettails" {
            if let VC = segue.destination as? PokeDettails  {
                if let poke = sender as? Pokemon{
                   VC.pokemon = poke
                    
                }
            }
    }
}

    
    
}


