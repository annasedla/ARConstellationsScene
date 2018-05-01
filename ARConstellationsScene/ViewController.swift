//
//  ViewController.swift
//  ARConstellationsScene
//
//  Created by Anna Sedlackova on 5/1/18.
//  Copyright © 2018 Anna Sedlackova. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = SCNScene()
        let box = SCNBox(width: 0.5, height: 0.5, length: 0.5, chamferRadius: 0)
        //let box = SCNPlane(width: 20, height: 200)
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "pisces.png")
        
        
        let sides = [
            UIColor.blue,          // Front
            UIColor.red,        // Right
            UIColor.green,        // Back
            UIColor.cyan,        // Left
            UIColor.yellow,        // Top
            UIColor.purple         // Bottom
        ]
        
        let materials = sides.map { (side) -> SCNMaterial in
            let material = SCNMaterial()
            material.diffuse.contents = side
            material.locksAmbientWithDiffuse = true
            return material
        }
        
        box.materials = materials
        let boxNode = SCNNode(geometry: box)
        boxNode.constraints = [SCNBillboardConstraint()]
        
        
        boxNode.position = SCNVector3(0,0,-4)
        //boxNode.transform = SCNMatrix4Rotate(boxNode.transform, Float.pi/2, 1, 1, 0)
        //boxNode.orientation.dele = sceneView.pointOfView!
        
        scene.rootNode.addChildNode(boxNode)
        
        // Set the scene to the view
        sceneView.scene = scene
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
       // let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
        //sceneView.scene = scene
        
        //let geometry = SCNSphere(radius: 0.2)
        //geometry.firstMaterial?.diffuse.contents = UIImage(named: "pisces.png")
        //let sphereNode = SCNNode(geometry: geometry)
        //sphereNode.position = SCNVector3(0, 0, -1)
        //sceneView.scene.rootNode.addChildNode(sphereNode)
        
        //let circleNode = createSphereNode(with: 0.2, color: .blue)
       // circleNode.position = SCNVector3(0, 0, -1) // 1 meter in front of camera
        //sceneView.scene.rootNode.addChildNode(circleNode)
    }
    
    //creates sphere
    func createSphereNode(with radius: CGFloat, color: UIColor) -> SCNNode {
        let geometry = SCNSphere(radius: radius)
        geometry.firstMaterial?.diffuse.contents = color
        let sphereNode = SCNNode(geometry: geometry)
        return sphereNode
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
