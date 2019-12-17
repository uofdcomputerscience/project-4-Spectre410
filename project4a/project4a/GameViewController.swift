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
    var nodes: [SKSpriteNode] = []
    var correct_nodes: [SKSpriteNode] = []
    var scene: SKScene?
    var scene2: SKScene?
    var last_Touched: SKSpriteNode?
    override func viewDidLoad() {
        scene = SKScene(size: skView.bounds.size)
        scene!.isUserInteractionEnabled = true
        let Width = skView.bounds.maxX - skView.bounds.minX
        let Height = skView.bounds.maxY - skView.bounds.minY
        scene2 = SKScene(size: skView.bounds.size)
        image = UIImage(named: "starrynight.png")
        // let num: [Int] = [3,2,1,0]
        for i in 0...3 {
            for j in 0...3 {
                
                let sImage = cropImage(image!, toRect: CGRect(x: CGFloat(i) * image!.size.width/4, y: CGFloat(j) * image!.size.height/4, width: image!.size.width/4, height: image!.size.height/4), viewWidth: Width * 0.98, viewHeight: Height * 0.98)
                let texture = SKTexture(image: sImage!)
                let node = SKSpriteNode(texture: texture)
                node.position = CGPoint(x: CGFloat(i) * Width/4 + Width/8, y: CGFloat(3-j) * Height/4 + Height/8)
                correct_nodes.append(node)
                scene2?.addChild(node)
            }
        }
        let rand_1 = [1,3,2,0]
        let rand_2 = [2,0,1,3]
        for i in rand_1 {
            for j in rand_2 {
                let sImage = cropImage(image!, toRect: CGRect(x: CGFloat(i) * image!.size.width/4, y: CGFloat(j) * image!.size.height/4, width: image!.size.width/4, height: image!.size.height/4), viewWidth: Width * 0.98, viewHeight: Height * 0.98)
                let texture = SKTexture(image: sImage!)
                let node = SKSpriteNode(texture: texture)
                node.position = CGPoint(x: CGFloat(i) * Width/4 + Width/8, y: CGFloat(j) * Height/4 + Height/8)
                nodes.append(node)
                scene?.addChild(node)
            }
        }
        
        
        skView.presentScene(scene)
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let location = touch.location(in: scene!)
        
        let t_node = scene!.nodes(at: location).first
        
        
        if last_Touched == nil {
            last_Touched = t_node as? SKSpriteNode
        }
        guard let last = last_Touched, let touched = t_node else { return }
        let temp = last.position
        last.position = touched.position
        touched.position = temp
        if last != touched {
            last_Touched = nil
        }

        
    }

    @IBAction func submitTapped(_ sender: Any) {
        var answer: Bool = false
        if scene == scene2 {
            answer = true
        }
        
        if answer == true {
            let vc = storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
            vc.time = timeStart.timeIntervalSinceNow
            navigationController?.pushViewController(vc, animated: true)
        }
        else {
            let controller = UIAlertController(title: "An error occured", message: "The image is not yet correct!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel) { _ in
                self.dismiss(animated: true, completion: nil)
            }
            controller.addAction(okAction)
            present(controller, animated: true)
        }
        
    }
    
    func cropImage(_ inputImage: UIImage, toRect cropRect: CGRect, viewWidth: CGFloat, viewHeight: CGFloat) -> UIImage?
    {
        let widthViewScale = viewWidth / inputImage.size.width
        let heightViewScale = viewHeight / inputImage.size.height
        
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


