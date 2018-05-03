//
//  ViewController.swift
//  ARConstellationsScene
//
//  Created by Anna Sedlackova on 5/1/18.
//  Copyright © 2018 Anna Sedlackova. All rights reserved.

import UIKit
import SceneKit
import ARKit
import CoreLocation

class ViewController: UIViewController, ARSCNViewDelegate, CLLocationManagerDelegate {

    //scene outlet
    @IBOutlet var sceneView: ARSCNView!
    
    //instance of location manager
    var locationManager: CLLocationManager!
    
    /*
     MARK: Location information
     */
    
    //stores information with the default star positions
    var baseLocation: CLLocation = CLLocation(latitude: 90, longitude: 0) // North Pole
    
    //keeps track of the current location using CoreLocation
    var currentLocation: CLLocation = CLLocation(latitude: 41.505493, longitude: -81.681290) // Default

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        MARK: - SCSScene()
        */
        
        //creates an instance of SCNScene
        let scene = SCNScene()
        
        //renders constellations based on the location on the hemispeheres
        //south vs north hemispehere, shifts the orientation
        renderConstellations(scene)
        
        // Set the scene to the view
        sceneView.scene = scene
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        /*
        MARK: - CLLocationManager()
        */
        
        //creates instance of the location manager
        locationManager = CLLocationManager()
        locationManager.delegate = self
        
        //accuracy up to 3km
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        //requests access to the phones location from user
        locationManager.requestWhenInUseAuthorization()
        
        //continuously updates users location
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
        
        //3km accuracy
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
    }
    
    /*
     MARK: Function that creates constellations
     Takes in image of a constellation
     Creates a 3D object and places the constellation on it
     */
    
    func placeConstellationInSpace(constellation: UIImage, x: Float, y: Float, z: Float, scene: SCNScene) {
        
        //box parameters
        let box = SCNBox(width: 2.9, height: 2.9, length: 0.001, chamferRadius: 0)
        
        //placing constellations over material
        let material = SCNMaterial()
        let boxNodes = SCNNode(geometry: box)
        material.diffuse.contents = constellation
        box.materials = [material]
        let boxNode = SCNNode(geometry: box)

        //adds constraints so the constellation is always facing the viewer
        boxNode.constraints = [SCNBillboardConstraint()]
        boxNode.position = SCNVector3(x, y, z)
        
        //transforms constallation oriantation based on location using the matrix transformations file
        if (baseLocation != currentLocation){
            boxNodes.transform = SCNMatrix4(MatrixTransforms.transformMatrix(for: simd_float4x4(boxNode.transform), originLocation: baseLocation, location: currentLocation))
        }
        scene.rootNode.addChildNode(boxNode)
    }
    
    //returns devices orientation
    func getHeading() -> CLDeviceOrientation {
        return self.locationManager.headingOrientation
    }
    
    /*
     MARK: - Default AR functions
     */
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        //detecting horizontal planes
        configuration.planeDetection = .horizontal
        configuration.isAutoFocusEnabled = true
        
        //this ensures constallations reappear on the users screen in the same orientation
        configuration.worldAlignment = .gravityAndHeading

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    /*
     MARK: - Rendering constellations on startup
     by placing them either lower or upper hemisphere orientation
     */
    
    //detects lower or upper hemisphere
    fileprivate func inLowerHemisphere() -> Bool {
        return self.currentLocation.coordinate.latitude < 0
    }
    
    //places constellation properly in space
    fileprivate func renderConstellations(_ scene: SCNScene) {        
        for con in Constants.constellations {
            if inLowerHemisphere() {
                placeConstellationInSpace(constellation: UIImage(named: con.name)!, x: con.coord.x * -1, y: con.coord.y * -1, z: con.coord.z, scene: scene)
            }
            else {
                placeConstellationInSpace(constellation: UIImage(named: con.name)!, x: con.coord.x, y: con.coord.y, z: con.coord.z, scene: scene)
            }
        }
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
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        print("session fail")
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        print("session was interrupted")
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        print("session interruption ended")
    }
}
