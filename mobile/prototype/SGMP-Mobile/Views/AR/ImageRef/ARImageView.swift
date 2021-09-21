import Foundation
import ARKit
import UIKit
import SwiftUI

class ARRefImageView : ARSCNView, ARSCNViewDelegate, ARSessionDelegate {
    
    init() {
        super.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        postInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect, options: [String : Any]? = nil) {
        super.init(frame: frame, options: options)
    }
    
    func postInit() {
        self.delegate = self
        self.showsStatistics = true
        self.session = ARSession()
        self.session.delegate = self
        let config = ARWorldTrackingConfiguration()
        config.frameSemantics.insert(.personSegmentation)
        config.maximumNumberOfTrackedImages = 10
        if let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "ARResources", bundle: nil) {
            config.detectionImages = referenceImages
        } else {
            print("ARResources not found")
        }
        self.session.run(config, options: [])
    }
    
    // MARK: - ARSCNViewDelegate
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        if let anchor = anchor as? ARImageAnchor {
            return ARRefImageNode(anchor: anchor)
        }
        return nil
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        if let anchor = anchor as? ARImageAnchor, let node = node as? ARRefImageNode
        {
            node.simdTransform = anchor.transform
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        self.session.currentFrame?.anchors
            .compactMap({ anchor in
                anchor as? ARNodeUpdateProtocol
            })
            .forEach({ node in
                node.renderer(renderer, updateAtTime: time)
            })
    }
    
    // MARK: - ARSessionDelegate
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        
    }
    
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        
    }
    
    // MARK: - UIRespondor
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
    }
}

struct ARRefImageViewRepresentable: UIViewRepresentable {

    func makeUIView(context: Context) -> ARRefImageView {
        ARRefImageView()
    }

    func updateUIView(_ uiView: ARRefImageView, context: Context) {
    }
}

