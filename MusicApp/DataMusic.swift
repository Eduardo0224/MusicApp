//
//  DataMusic.swift
//  MusicApp
//
//  Created by Eduardo on 22/12/15.
//  Copyright © 2015 EduardoAndrade. All rights reserved.
//

import Foundation

class DataMusic {
    
    struct Cancion {
        let titulo : String
        let cantante : String
        let portada : String
        
        init (tituloCancion : String, cantante: String, portadaImagen : String) {
            self.titulo = tituloCancion
            self.cantante = cantante
            self.portada = portadaImagen
        }
    }
    
    let canciones = [
        Cancion(tituloCancion: "Voices in a dream", cantante: "Echoes of Eternity", portadaImagen: "The Forgotten Goddess"),
        Cancion(tituloCancion: "Se taire", cantante: "Kells", portadaImagen: "Anachromie"),
        Cancion(tituloCancion: "Bleu", cantante: "Kells", portadaImagen: "Anachromie"),
        Cancion(tituloCancion: "Illusion d'une aire", cantante: "Kells", portadaImagen: "Anachromie"),
        Cancion(tituloCancion: "L'heure que le temps va figer", cantante: "Kells", portadaImagen: "Anachromie")
    ]
}

extension Array {
    func randomItem() -> Element {
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}
