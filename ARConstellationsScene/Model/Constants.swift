//
//  Constants.swift
//  ARConstellationsScene
//
//  Created by Daniel Grigsby on 5/3/18.
//  Copyright © 2018 Anna Sedlackova. All rights reserved.
//

import Foundation

public class Constants {
    
    /*
     MARK: List of all main constellations on display including their position on North Pole
     Taken from http://www.constellation-guide.com/constellation-map/
     */
    static let constellations = [
        Constellation(name: "pisces", coord: Coordinate( x: 4, y: 0, z: 5)),
        Constellation(name: "scorpio", coord: Coordinate(x: -3, y: -3, z: 5)),
        Constellation(name: "aries", coord:  Coordinate(x: 8, y: 7, z: 5)),
        Constellation(name: "taurus", coord: Coordinate(x: 16, y: 7, z: 5)),
        Constellation(name: "gemini", coord: Coordinate(x: 8, y: 5, z: -5)),
        Constellation(name: "cancer", coord: Coordinate(x: 4, y: 0, z: -5)),
        Constellation(name: "leo", coord: Coordinate(x: 0, y: 0, z: -5)),
        Constellation(name: "virgo", coord: Coordinate(x: -3, y: 0, z: -5)),
        Constellation(name: "libra", coord: Coordinate(x: 0, y: -3, z: 5)),
        Constellation(name: "saggitarius", coord: Coordinate(x: -7, y: -3, z: 5)),
        Constellation(name: "capricorn", coord: Coordinate(x: -7, y: -5, z: -5)),
        Constellation(name: "aquarias", coord: Coordinate(x: -13, y: -5, z: -5)),
        Constellation(name: "orion", coord: Coordinate(x: 16, y: 0, z: 5)),
        Constellation(name: "ursamajor", coord: Coordinate(x: 0, y: 4, z: -5)),
        Constellation(name: "ursaminor", coord: Coordinate(x: 0, y: 15, z: -5)),
    ]
}

//struct for coordinate and name of a constellations to be transformed
public struct Constellation {
    let name: String
    let coord: Coordinate
}

public struct Coordinate {
    let x: Float
    let y: Float
    let z: Float
}
