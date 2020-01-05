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
        view.bringSubviewToFront(topLeftCircleImageView)
    }

    func addPanGesture(view: UIView) {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(MainViewController.handlePan(sender:)))
        view.addGestureRecognizer(pan)
        
    }
    
    @objc func handlePan(sender: UIPanGestureRecognizer) {
        let fileView = sender.view!
        
        switch sender.state {
        case .began, .changed:
            moveViewWithPan(view: fileView, sender: sender)
            
        case .ended:
            if fileView.frame.intersects(bottomRightCircleImageView.frame) {
                deleteView(view: fileView)
            } else {
                returnViewToOrigin(view: fileView)
            }
            
        default:
            break
        }
    }
    
    func moveViewWithPan(view: UIView, sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: view)
    }
    
    func returnViewToOrigin(view: UIView) {
        UIView.animate(withDuration: 0.3, animations: {
            view.frame.origin = self.fileViewOrigin
        })
    }
    
    func deleteView(view: UIView) {
        print("intersected view")
        UIView.animate(withDuration: 0.3, animations: {
            view.alpha = 0.0
            self.returnViewToOrigin(view: view)
            view.alpha = 1.0
        })
        // haptic, play playlist
    }

}

