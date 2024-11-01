//
//  Carousel.swift
//  AtlysAssignment-iOS
//
//  Created by Vikas Kumar on 30/10/24.
//
import Foundation

struct Carousel {
    let country: String
    let visa: String
    let image: String
}

extension Carousel {
    // Mock data for Carousel View
    static func datasource() -> [Carousel] {
        [
            Carousel(country: "Singapore", visa: "10k+ Visas on Atlys", image: "singapore"),
            Carousel(country: "Malaysia", visa: "12k+ Visas on Atlys", image: "malaysia"),
            Carousel(country: "Dubai", visa: "7k+ Visas on Atlys", image: "dubai")
        ]
    }
}
