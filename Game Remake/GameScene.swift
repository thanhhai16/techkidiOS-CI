//
//  GameScene.swift
//  Game Remake
//
//  Created by Hai on 8/29/16.
//  Copyright (c) 2016 Hai. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var plane:SKSpriteNode!
    override func didMoveToView(view: SKView) {
        addBackground()
        addPlane()
        }
    
    func addBackground() {
        // 1
        let background = SKSpriteNode(imageNamed: "background.png")
        //2
        background.anchorPoint = CGPointZero
        background.position = CGPointZero
        //3
        addChild(background)
    }
    func addPlane() {
        //1
        plane = SKSpriteNode(imageNamed: "plane2.png")
        //2
        plane.anchorPoint = CGPointMake(0.5, 0.5)
        plane.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        //3
        addChild(plane)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
           }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //print ("touchesMoved")
        //print ("touches count : \(touches.count)")
        //prin (touches.first)
        if let touch = touches.first{
                let currentTouch = touch.locationInNode(self)
                let previousTouch = touch.previousLocationInNode(self)
                plane.position.x = max(plane.position.x, plane.size.width/2)
                plane.position.x = min(plane.position.x, self.frame.size.width - plane.size.width/2)
                plane.position.y = max(plane.position.y, plane.size.height/2)
                plane.position.y = min(plane.position.y, self.frame.size.height - plane.size.height/2)
            
                // 2 Caculate movement vector and move plane by this vector

                plane.position = plane.position.add(currentTouch.subtract(previousTouch))

       
        }
    }
        override func update(currentTime: CFTimeInterval) {
            print("currentTime : \(currentTime)")
            
    }
    
}
