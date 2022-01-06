//
//  MainViewController.swift
//  Draftsman
//
//  Created by Paweł Brzozowski on 06/01/2022.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //Setup naviagtion item
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(leftBarButtonTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(rightBarButtonTapped))
    }
    


    // MARK: - NavigationItem targets:
    
    @objc func leftBarButtonTapped() {
        print("LEFT BAR BUTTON")
    }
    @objc func rightBarButtonTapped() {
        print("RIGHT BAR BUTTON")
    }
}
