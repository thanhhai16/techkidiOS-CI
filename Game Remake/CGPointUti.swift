//
//  CGPointUti.swift
//  Game Remake
//
//  Created by Hai on 9/4/16.
//  Copyright © 2016 Hai. All rights reserved.
//

import Foundation

import SpriteKit

extension CGPoint{
    func add(other: CGPoint) -> CGPoint {
        let retX = self.x + other.x
        let retY = self.y + other.y

        return CGPoint(x: retX, y: retY)
    }
    func subtract(other : CGPoint) -> CGPoint {
        return CGPoint(x: self.x - other.x, y: self.y - other.y)
    }
    func mutiply(k : CGFloat) -> CGPoint {
        return CGPoint (x: (self.x)*k, y: (self.y)*k)
    }
    func distance(other: CGPoint) -> Float {
    let b = pow(self.x - other.x,2) + pow(self.y - other.y,2)
    let d = sqrt(b)
    return Float(d)
    }
    func normalize(other : CGPoint) -> CGPoint {
        let ux = x/sqrt(pow(self.x - other.x,2) + pow(self.y - other.y,2))
        let uy = y/sqrt(pow(self.x - other.x,2) + pow(self.y - other.y,2))
        return CGPoint(x: ux, y: uy)
    }
    
}