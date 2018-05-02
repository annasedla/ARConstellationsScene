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
import CoreLocation

class ViewController: UIViewController, ARSCNViewDelegate, CLLocationManagerDelegate {

    @IBOutlet var sceneView: ARSCNView!
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = SCNScene()
       
        placeConstellationInSpace(constellation: UIImage(named: "pisces")!, x: 0, y: 4, z: -5, scene: scene)
        placeConstellationInSpace(constellation: UIImage(named: "scorpio")!, x: 2, y: 2, z: -5, scene: scene)
        placeConstellationInSpace(constellation: UIImage(named: "cancer")!, x: 4, y: 0, z: -5, scene: scene)

        // Set the scene to the view
        sceneView.scene = scene
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
        
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
    
    // places constellation
    func placeConstellationInSpace(constellation: UIImage, x: Float, y: Float, z: Float, scene: SCNScene) {
        let box = SCNBox(width: 2.9, height: 2.9, length: 0.001, chamferRadius: 0)
        let material = SCNMaterial()
        material.diffuse.contents = constellation
        box.materials = [material]
        let boxNode = SCNNode(geometry: box)
        boxNode.constraints = [SCNBillboardConstraint()]
        boxNode.position = SCNVector3(x, y, z)
        //boxNode.transform = SCNMatrix4Rotate(boxNode.transform, Float.pi/2, 0, 1, 1)
        //boxNode.orientation.dele = sceneView.pointOfView!
        scene.rootNode.addChildNode(boxNode)
    }
    
    func getHeading() -> CLDeviceOrientation {
        return self.locationManager.headingOrientation
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        configuration.isAutoFocusEnabled = true
        configuration.worldAlignment = .gravityAndHeading

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
