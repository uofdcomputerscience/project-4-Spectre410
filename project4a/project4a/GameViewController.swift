//
//  GameViewController.swift
//  project4a
//
//  Created by Matt Pritchett on 12/15/19.
//  Copyright © 2019 Matt Pritchett. All rights reserved.
//

import SpriteKit

class GameViewController: UIViewController {
    @IBOutlet weak var skView: SKView!
    let num_nodes: Int = 16
    var image: UIImage?
    var timeStart: Date = Date()
    override func viewDidLoad() {
        let scene = SKScene(size: skView.bounds.size)
        let Width = skView.bounds.maxX - skView.bounds.minX
        let Height = skView.bounds.maxY - skView.bounds.minY
        image = UIImage(named: "starrynight.png")
        for i in 0...3 {
            for j in 0...3 {
                
                let sImage = cropImage(image!, toRect: CGRect(x: CGFloat(i) * Width/8, y: CGFloat(j) * Height/8, width: Width/8, height: Height/8), viewWidth: Width/4, viewHeight: Height/4)
                let texture = SKTexture(image: sImage!)
                let node = SKSpriteNode(texture: texture)
                node.position = CGPoint(x: CGFloat(i) * Width/4 + Width/8, y: CGFloat(j) * Height/4 + Height/8)
                
                scene.addChild(node)
            }
            
        }
        
        skView.presentScene(scene)
        
    }
    @IBAction func submitTapped(_ sender: Any) {
    }
    
    func cropImage(_ inputImage: UIImage, toRect cropRect: CGRect, viewWidth: CGFloat, viewHeight: CGFloat) -> UIImage?
    {
        let widthViewScale = inputImage.size.width / viewWidth
                                 
        let heightViewScale = inputImage.size.height / viewHeight
        
        // Scale cropRect to handle images larger than shown-on-screen size
        let cropZone = CGRect(x:cropRect.origin.x * widthViewScale,
                              y:cropRect.origin.y * heightViewScale,
                              width:cropRect.size.width * widthViewScale,
                              height:cropRect.size.height * heightViewScale)
        
        // Perform cropping in Core Graphics
        guard let cutImageRef: CGImage = inputImage.cgImage?.cropping(to:cropZone)
            else {
                return nil
        }
        
        // Return image to UIImage
        let croppedImage: UIImage = UIImage(cgImage: cutImageRef)
        return croppedImage
    }
}
