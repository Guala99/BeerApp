//
//  Beer.swift
//  BeerApp
//
//  Created by Andrea Gualandris on 01/04/2022.
//

import Foundation

struct BeerModel: Decodable {
    var name: String
    var tagline: String
    var description: String
    var image_url: String
}
