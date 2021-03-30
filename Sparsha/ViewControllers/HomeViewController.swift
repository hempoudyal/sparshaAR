//
//  ViewController.swift
//  Sparsha
//
//  Created by Hem Poudyal on 2/21/21.
//

import UIKit
import SceneKit
import ARKit

class HomeViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        //let scene = SCNScene(named: "art.scnassets/scene.scn")!
        
        // Set the scene to the view
        //sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        //guard let tulipsObject = ARReferenceObject.referenceObjects(inGroupNamed: "Tulips", bundle: Bundle.main) else { return }
        //configuration.detectionObjects = tulipsObject
        
        guard let lampObject = ARReferenceObject.referenceObjects(inGroupNamed: "Lamp", bundle: Bundle.main) else { return }
        configuration.detectionObjects = lampObject

        // Run the view's session
        sceneView.session.run(configuration)
        sceneView.autoenablesDefaultLighting = true
        sceneView.automaticallyUpdatesLighting = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
    /*
    // Override to create and configure nodes for anchors added to the view's session
     //Tulips
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
        let animator = SCNAction.scale(by: 10, duration: 3)
        
        if let objectAnchor = anchor as? ARObjectAnchor{
            let plane = SCNPlane(width: 0.4, height: 0.225)
            //plane.cornerRadius = 0.1
            
            let displayScene = SKScene(fileNamed: "TulipsScene")
            plane.firstMaterial?.diffuse.contents = displayScene
            plane.firstMaterial?.isDoubleSided = true
            plane.firstMaterial?.diffuse.contentsTransform = SCNMatrix4Translate(SCNMatrix4MakeScale(1, -1, 1), 0, 1, 0)
            
            
            let planeNode = SCNNode(geometry: plane)
            //planeNode.position = SCNVector3Zero
            planeNode.position = SCNVector3Make(objectAnchor.referenceObject.center.x , objectAnchor.referenceObject.center.y + 0.25, objectAnchor.referenceObject.center.z - 0.4)
            
            var tulipNode = SCNNode()
            if let tulipScene = SCNScene(named: "art.scnassets/Tulip.usdz") {
                tulipNode = tulipScene.rootNode.childNodes.first!
                tulipNode.position = SCNVector3(0.06, 0, 0.04)
                tulipNode.scale = SCNVector3Make(0.05, 0.05, 0.05)
                
                let min = tulipNode.boundingBox.min
                let max = tulipNode.boundingBox.max
                tulipNode.pivot = SCNMatrix4MakeTranslation(min.x + (max.x - min.x) / 2,
                                                            min.y + (max.y - min.y) / 2,
                                                            min.z + (max.z - min.z) / 2)
            
                
               
                planeNode.addChildNode(tulipNode)
                //planeNode.addChildNode(tulipLight)
                tulipNode.runAction(rotateObject())
                tulipNode.runAction(animator)
            }
            
            node.addChildNode(planeNode)
            
        }
        return node
    }
 
    */
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
        
        if let objectAnchor = anchor as? ARObjectAnchor{
           //show bulb vc
            DispatchQueue.main.async {
                let bulbVC = BulbViewController()
                self.navigationController?.present(bulbVC, animated: true, completion: nil)
                self.performSegue(withIdentifier: "showBulbVC", sender: nil)
            }
            
        }
        return node
    }
    
    func rotateObject() -> SCNAction {
        let action = SCNAction.rotateBy(x: 0, y: CGFloat(GLKMathDegreesToRadians(360)), z: 0, duration: 3)
        let repeatAction = SCNAction.repeatForever(action)
        return repeatAction
    }
    
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
