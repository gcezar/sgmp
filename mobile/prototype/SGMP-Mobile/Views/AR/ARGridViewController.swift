import Foundation
import ARKit
import UIKit
import SwiftUI

class ARGridViewController : UIViewController, ARSCNViewDelegate, ARSessionDelegate {
    
    var arView : ARSCNView = ARSCNView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(arView)
        arView.frame = self.view.bounds
        arView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        arView.delegate = self
        arView.showsStatistics = true
        arView.session = ARSession()
        arView.session.delegate = self
        arView.isUserInteractionEnabled = true
        arView.isMultipleTouchEnabled = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let config = ARWorldTrackingConfiguration()
        config.frameSemantics.insert(.personSegmentationWithDepth)
        config.maximumNumberOfTrackedImages = 4
        if let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "ARResources", bundle: nil) {
            config.detectionImages = referenceImages
        } else {
            print("ARResources not found")
        }
        arView.session.run(config, options: [])
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        arView.session.pause()
        UIApplication.shared.windows.forEach { window in
            if window != UIApplication.shared.keyWindow {
                window.isHidden = true
            }
        }
    }
    
    // MARK: - ARSCNViewDelegate
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        if let anchor = anchor as? ARImageAnchor {
            let node = ARInteractiveSwiftUINode(viewSize: .init(width: 300, height: 300),
                                            planeSize: .init(width: anchor.referenceImage.physicalSize.width, height: anchor.referenceImage.physicalSize.height),
                                            view: ARRefImageCoverView())
            return node
            
        }
        return nil
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        self.arView.session.currentFrame?.anchors
            .compactMap({ anchor in
                anchor as? ARNodeUpdateProtocol
            })
            .forEach({ node in
                node.renderer(renderer, updateAtTime: time)
            })
    }
    
    // MARK: - ARSessionDelegate
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        let env = EnvironmentManager.shared.env
        DispatchQueue.main.async {
            switch camera.trackingState {
            case .notAvailable:
                env.showDecoration(view: AnyView(ToastView(title: "Camera Not Available")), forTime: .seconds(1))
            case .limited(_):
                env.showDecoration(view: AnyView(ToastView(title: "Tracking Limited")), forTime: .seconds(1))
            case .normal:
                env.showDecoration(view: AnyView(ToastView(title: "Tracking Normal")), forTime: .seconds(1))
            }
        }
    }
    
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        
    }
}

struct ARGridViewControllerRepresentable : UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ARGridViewController {
        return ARGridViewController()
    }
    
    func updateUIViewController(_ uiViewController: ARGridViewController, context: Context) {
        
    }
    
    static func dismantleUIViewController(_ uiViewController: ARGridViewController, coordinator: ()) {

    }
    
    typealias UIViewControllerType = ARGridViewController
}
