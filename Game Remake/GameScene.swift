//
//  GameScene.swift
//  Game Remake
//
//  Created by Hai on 8/29/16.
//  Copyright (c) 2016 Hai. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    // Node
    var plane:SKSpriteNode!
    var bullets : [SKSpriteNode] = []
    var enemy:SKSpriteNode!
    var enemys : [SKSpriteNode] = []
    var enemyBullets : [SKSpriteNode] = []
    // Counter
    var bullteIntervalCount = 0
    var enemyIntervalCount = 0
    // Time
    var lastUpdateTime : NSTimeInterval = -1
    override func didMoveToView(view: SKView) {
        addBackground()
        addPlane()
        addEnemys()
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
        //plane.anchorPoint = CGPointMake(0.5, 0.5)
        plane.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        // 3
        let shot = SKAction.runBlock {
            self.addBullets()
        }
        let periodShot = SKAction.sequence([shot, SKAction.waitForDuration(0.3)])
        
        let shotForever = SKAction.repeatActionForever(periodShot)
        //3
        plane.runAction(shotForever)
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
        for (bulletIndex, bullet) in bullets.enumerate() {
            if bullet.position.y > self.frame.maxY{
                bullet.removeFromParent()
                bullets.removeAtIndex(bulletIndex)
            }
            for (enemyIndex, enemy) in enemys.enumerate() {
                // 1
                let bulletFrame = bullet.frame
                let enemyFrame = enemy.frame
                // 2 check
                if CGRectIntersectsRect(bulletFrame, enemyFrame) {
                    // 3 remove
                    bullet.removeFromParent()
                    enemy.removeFromParent()
                    // 4
                    bullets.removeAtIndex(bulletIndex)
                    enemys.removeAtIndex(enemyIndex)
                }
            }
        }
        
    }
    func addBullets() {
        // 1
        let bullet = SKSpriteNode(imageNamed: "bullet.png")
        // 2 Set bullet position
        bullet.position.y = plane.frame.maxY + bullet.frame.maxY * 1.2
        bullet.position.x = plane.position.x
        //bullet.position.y = plane.position.y
        // 3
        self.addChild(bullet)
        //4
        let fly = SKAction.moveByX(0, y: 20, duration: 0.1)
        bullet.runAction(SKAction.repeatActionForever(fly))
        bullets.append(bullet)
        
    }
    func addEnemys() {
        //let addEnemy = SKAction.runBlock {
        // 1 Add enemy
        self.enemy = SKSpriteNode(imageNamed: "enemy_plane_white_1.png")
        
        // 2 Set enemy position
        let PlaneX = UInt32(CGRectGetMaxX(self.frame))
        let randomX = CGFloat(arc4random_uniform(PlaneX))
        self.enemy.position.x = randomX
        self.enemy.position.y = self.frame.size.height
        
        // 3 move Enemy
        let moveEnemy = SKAction.moveByX(0, y: -10, duration: 0.2)
        self.enemy.runAction(SKAction.repeatActionForever(moveEnemy))
        
        // 4 Shot
        self.enemys.append(self.enemy)
        let enemyShot = SKAction.runBlock{
            self.addEnemyBullet()
        }
        let enemyShotPeriod = SKAction.sequence([enemyShot, SKAction.waitForDuration(1)])
        self.enemy.runAction(SKAction.repeatActionForever(enemyShotPeriod))
        // 5
        self.addChild(self.enemy)
        //}
        
        //let enemyPeriod = SKAction.sequence([addEnemy, SKAction.waitForDuration(3)])
        //self.runAction(SKAction.repeatActionForever(enemyPeriod))
        
        
        
    }
    func addEnemyBullet(){
        // 1
        
        let enemyBullet = SKSpriteNode(imageNamed: "bullet_enemy.png")
        
        // 2
        enemyBullet.position.y = enemy.frame.minY - enemyBullet.frame.maxY
        enemyBullet.position.x = enemy.position.x
        
        // 3
        
        self.addChild(enemyBullet)
        
        // 4
        if enemyBullet.position != self.plane.position {
            
            let moveto = SKAction.runBlock {
                
                
                let fly = SKAction.moveTo(self.plane.position, duration: NSTimeInterval (self.plane.position.distance(enemyBullet.position)/100))
                enemyBullet.runAction(SKAction.repeatActionForever(fly))
                self.enemyBullets.append(enemyBullet)
            }
            
            let moveToPeriod = SKAction.sequence([moveto, SKAction.waitForDuration(0.1)])
            enemyBullet.runAction(SKAction.repeatActionForever(moveToPeriod))
        }
        else {
            
        }
        
    }
    
}
