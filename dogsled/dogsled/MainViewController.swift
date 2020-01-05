//
//  ViewController.swift
//  dogsled
//
//  Created by Mikalangelo Wessel on 1/5/20.
//  Copyright © 2020 Mikalangelo Wessel. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var topLeftCircleImageView: UIImageView!
    @IBOutlet weak var bottomRightCircleImageView: UIImageView!
    
    var fileViewOrigin: CGPoint!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        topLeftCircleImageView.layer.masksToBounds = true
        topLeftCircleImageView.layer.cornerRadius = topLeftCircleImageView.bounds.width / 2
        
        bottomRightCircleImageView.layer.masksToBounds = true
        bottomRightCircleImageView.layer.cornerRadius = bottomRightCircleImageView.bounds.width / 2
        
        addPanGesture(view: topLeftCircleImageView)
        fileViewOrigin = topLeftCircleImageView.frame.origin
    }

    func addPanGesture(view: UIView) {
        print("huh")
        let pan = UIPanGestureRecognizer(target: self, action: #selector(MainViewController.handlePan(sender:)))
        view.addGestureRecognizer(pan)
        
    }
    
    @objc func handlePan(sender: UIPanGestureRecognizer) {
        let fileView = sender.view!
        let translation = sender.translation(in: view)
        
        switch sender.state {
        case .began, .changed:
            fileView.center = CGPoint(x: fileView.center.x + translation.x, y: fileView.center.y + translation.y)
            sender.setTranslation(CGPoint.zero, in: view)
        case .ended:
            break
        default:
            break
        }
        
        
    }

}

