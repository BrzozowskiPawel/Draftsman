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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Setup naviagtion item
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(leftBarButtonTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(rightBarButtonTapped))
        
        // Setup the canvasView
        canvasView.delegate = self
        canvasView.drawing = drawning // set drawning property to our drawning obejct creted
        canvasView.alwaysBounceVertical = true
        canvasView.drawingPolicy = .anyInput
        
        // Setup the toolpicker
        toolPicker.addObserver(canvasView)
        toolPicker.setVisible(true, forFirstResponder: canvasView)
        canvasView.becomeFirstResponder()
        canvasView.backgroundColor = .clear
        canvasView.isOpaque = false
        
        // Setupview
        self.view.addSubview(canvasView)
    }
    


    // MARK: - NavigationItem targets:
    
    @objc func leftBarButtonTapped() {
        print("LEFT BAR BUTTON")
    }
    @objc func rightBarButtonTapped() {
        print("RIGHT BAR BUTTON")
    }
}
