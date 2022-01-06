//
//  MainViewController.swift
//  Draftsman
//
//  Created by Paweł Brzozowski on 06/01/2022.
//

import UIKit
import PencilKit
import PhotosUI

class MainViewController: UIViewController, PKCanvasViewDelegate, PKToolPickerObserver {

    let canvasView = PKCanvasView()

    // Place to save drawning.
    var drawning =  PKDrawing()
    
    let toolPicker = PKToolPicker.init()
    
    var toolPickerVisibility: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set main view color to white to make naviagtion also white
        self.view.backgroundColor = UIColor.white
        
        //Setup naviagtion item
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(leftBarButtonTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "paintbrush"), style: .plain, target: self, action: #selector(rightBarButtonTapped))
        
        // Setup the canvasView
        canvasView.delegate = self
        canvasView.drawing = drawning // set drawning property to our drawning obejct creted
        canvasView.alwaysBounceVertical = true
        canvasView.drawingPolicy = .anyInput
        
        // Setup the toolpicker
        toolPicker.addObserver(canvasView)
        toolPicker.setVisible(toolPickerVisibility, forFirstResponder: canvasView)
        canvasView.becomeFirstResponder()
        canvasView.backgroundColor = .clear
        canvasView.isOpaque = false
        
        // Setup canvasView
        self.view.addSubview(canvasView)
        
        // Setup layout of canvas
        canvasView.backgroundColor = UIColor.white
        canvasView.translatesAutoresizingMaskIntoConstraints = false
        canvasView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        canvasView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        canvasView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        canvasView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    


    // MARK: - NavigationItem targets:
    
    // Saving photo to the camerra roll
    @objc func leftBarButtonTapped() {
        // Save to photo roll
        UIGraphicsBeginImageContextWithOptions(canvasView.bounds.size, false, UIScreen.main.scale)
        
        canvasView.drawHierarchy(in: canvasView.bounds, afterScreenUpdates: true)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if image != nil {
            PHPhotoLibrary.shared().performChanges {
                PHAssetChangeRequest.creationRequestForAsset(from: image!)
            } completionHandler: { succes, error in
                // Deal with error
            }
        }
        
        // Dispaly alert that photo have been saved
        let alert = UIAlertController(title: "Photo saved", message: "Your photo has been saved to the camera roll.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func rightBarButtonTapped() {
        
        toolPickerVisibility.toggle()
        toolPicker.setVisible(toolPickerVisibility, forFirstResponder: canvasView)
    }
}
