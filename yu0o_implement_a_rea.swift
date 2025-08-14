import UIKit
import ARKit
import RealityKit

class ARVRModuleSimulator: UIViewController, ARSessionDelegate {
    let arView = ARView()
    let vrButton = UIButton(type: .system)
    let simulationModeLabel = UILabel()
    let simulationStatusLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupARView()
        setupVRButton()
        setupLabels()
    }

    func setupARView() {
        arView.frame = view.bounds
        arView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        arView.session.delegate = self
        view.addSubview(arView)
    }

    func setupVRButton() {
        vrButton.setTitle("Enter VR Mode", for: .normal)
        vrButton.addTarget(self, action: #selector(toggleVRMode), for: .touchUpInside)
        view.addSubview(vrButton)
        vrButton.translatesAutoresizingMaskIntoConstraints = false
        vrButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        vrButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
    }

    func setupLabels() {
        simulationModeLabel.text = "Simulation Mode: AR"
        simulationStatusLabel.text = "Simulation Status: Not Running"
        view.addSubview(simulationModeLabel)
        view.addSubview(simulationStatusLabel)
        simulationModeLabel.translatesAutoresizingMaskIntoConstraints = false
        simulationStatusLabel.translatesAutoresizingMaskIntoConstraints = false
        simulationModeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        simulationModeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        simulationStatusLabel.topAnchor.constraint(equalTo: simulationModeLabel.bottomAnchor, constant: 10).isActive = true
        simulationStatusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    @objc func toggleVRMode() {
        if arView.session.currentFrame != nil {
            let vrAnchor = try! ARAnchor(name: "VRAnchor")
            arView.session.add(anchor: vrAnchor)
            simulationModeLabel.text = "Simulation Mode: VR"
            simulationStatusLabel.text = "Simulation Status: Running"
        } else {
            simulationStatusLabel.text = "Simulation Status: Failed to initialize"
        }
    }

    func session(_ session: ARSession, didFailWithError error: Error) {
        simulationStatusLabel.text = "Simulation Status: Failed with error \(error.localizedDescription)"
    }
}