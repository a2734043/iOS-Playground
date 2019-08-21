//
//  ViewController.swift
//  ARKitTest
//
//  Created by 陳鍵群 on 2018/5/24.
//  Copyright © 2018年 陳鍵群. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {
    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configuration.planeDetection = [.horizontal]
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints,ARSCNDebugOptions.showWorldOrigin]
        self.sceneView.session.run(configuration)
        self.sceneView.autoenablesDefaultLighting = true
        self.configuration.planeDetection = .horizontal
        self.sceneView.delegate = self
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBAction func addNode(_ sender: Any) {
        
//        node.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.03)
//        node.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
//        node.geometry?.firstMaterial?.specular.contents = UIColor.white
//        node.position = SCNVector3Make(0, 0, 0.2)
//        self.sceneView.scene.rootNode.addChildNode(node)
//        node.eulerAngles.y = .pi
        
//        guard let secretScene = SCNScene.init(named: "art.scnassets/BowBoy.dae") else{
//            return
//        }
//        let node = SCNNode()
////        node.eulerAngles.x = -(.pi / 2)
//        node.position = SCNVector3Make(0, 0, 0)
//        node.scale = SCNVector3Make(0.0009, 0.0009, 0.0009)
//        for child in secretScene.rootNode.childNodes{
//            node.addChildNode(child)
//        }
//        self.sceneView.scene.rootNode.addChildNode(node)
        
        guard let shipScene = SCNScene(named: "art.scnassets/ship.scn"),
            let shipNode = shipScene.rootNode.childNode(withName: "ship", recursively: false)
            else { return }
        shipNode.position = SCNVector3Make(0, 0, 0)
        
        self.sceneView.scene.rootNode.addChildNode(shipNode)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: ARSCNViewDelegate{
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else{return}
        
        let width = CGFloat(planeAnchor.extent.x)
        let height = CGFloat(planeAnchor.extent.z)
        let plane = SCNPlane(width: width, height: height)
        
        plane.materials.first?.diffuse.contents = UIColor.blue
        
        let planeNode = SCNNode(geometry: plane)
        
        let x = CGFloat(planeAnchor.center.x)
        let y = CGFloat(planeAnchor.center.y)
        let z = CGFloat(planeAnchor.center.z)
        planeNode.position = SCNVector3(x,y,z)
        planeNode.eulerAngles.x = -(.pi / 2)
        
        node.addChildNode(planeNode)
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as?  ARPlaneAnchor,
            let planeNode = node.childNodes.first,
            let plane = planeNode.geometry as? SCNPlane
            else { return }
        
        let width = CGFloat(planeAnchor.extent.x)
        let height = CGFloat(planeAnchor.extent.z)
        plane.width = width
        plane.height = height
        
        let x = CGFloat(planeAnchor.center.x)
        let y = CGFloat(planeAnchor.center.y)
        let z = CGFloat(planeAnchor.center.z)
        planeNode.position = SCNVector3(x, y, z)
    }
}

