//
//  MatrixTransforms.swift
//  ARConstellationsScene
//
//  Created by Daniel Grigsby on 5/2/18.
//  Copyright © 2018 Anna Sedlackova. All rights reserved.
//

import Foundation
import GLKit.GLKMatrix4
import SceneKit
import CoreLocation


class MatrixTransforms {
    
    // Usage: boxNode.transform = SCNMatrix4(MatrixTransforms.transformMatrix(for: simd_float4x4(boxNode.transform), originLocation: baseLocation, location: currentLocation))
    // var baseLocation = CLLocation(latitude: 41.505493, longitude: -81.681290) // Cleveland OH
    // var currentLocation: CLLocation = CLLocation(latitude: 41.505493, longitude: -81.681290) // Default
    // locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
    // Code found in these files is a mix of
    //  Stackoverflow snippets
    // This CoreLocation guide: bit.ly/2Kvc3lm
    // Our own modifications to fit swift 3/4
    
    //    column 0  column 1  column 2  column 3
    //         1        0         0       X          x        x + X*w 
    //         0        1         0       Y      x   y    =   y + Y*w 
    //         0        0         1       Z          z        z + Z*w 
    //         0        0         0       1          w           w    
    
    static func translationMatrix(with matrix: matrix_float4x4, for translation : vector_float4) -> matrix_float4x4 {
        var matrix = matrix
        matrix.columns.3 = translation
        return matrix
    }
    
    //    column 0  column 1  column 2  column 3
    //        cosθ      0       sinθ      0    
    //         0        1         0       0    
    //       −sinθ      0       cosθ      0    
    //         0        0         0       1    
    
   static func rotateAroundY(with matrix: matrix_float4x4, for degrees: Float) -> matrix_float4x4 {
        var matrix : matrix_float4x4 = matrix
        
        matrix.columns.0.x = cos(degrees)
        matrix.columns.0.z = -sin(degrees)
        
        matrix.columns.2.x = sin(degrees)
        matrix.columns.2.z = cos(degrees)
        return matrix.inverse
    }
    
   static func transformMatrix(for matrix: simd_float4x4, originLocation: CLLocation, location: CLLocation) -> simd_float4x4 {
        let distance = Float(location.distance(from: originLocation))
        let bearing = getBearingBetweenTwoPoints(point1: originLocation, point2: location)
        let position = vector_float4(0.0, 0.0, -distance, 0.0)
        let translationMatrix = self.translationMatrix(with: matrix_identity_float4x4, for: position)
        let rotationMatrix = rotateAroundY(with: matrix_identity_float4x4, for: Float(bearing))
        let transformMatrix = simd_mul(rotationMatrix, translationMatrix)
        return simd_mul(matrix, transformMatrix)
    }
    
    
    static func degreesToRadians(degrees: Double) -> Double { return degrees * .pi / 180.0 }
    static func radiansToDegrees(radians: Double) -> Double { return radians * 180.0 / .pi }
    
    static func getBearingBetweenTwoPoints(point1 : CLLocation, point2 : CLLocation) -> Double {
        
        let lat1 = degreesToRadians(degrees: point1.coordinate.latitude)
        let lon1 = degreesToRadians(degrees: point1.coordinate.longitude)
        
        let lat2 = degreesToRadians(degrees: point2.coordinate.latitude)
        let lon2 = degreesToRadians(degrees: point2.coordinate.longitude)
        
        let dLon = lon2 - lon1
        
        let y = sin(dLon) * cos(lat2)
        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon)
        let radiansBearing = atan2(y, x)
        
        return radiansBearing
    }
    
}
