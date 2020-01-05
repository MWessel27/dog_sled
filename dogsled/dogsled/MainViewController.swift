//
//  ViewController.swift
//  dogsled
//
//  Created by Mikalangelo Wessel on 1/5/20.
//  Copyright © 2020 Mikalangelo Wessel. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var playImageView: UIImageView!
    @IBOutlet weak var bottomRightArea: UIView!
    @IBOutlet weak var topRightArea: UIView!
    @IBOutlet weak var topLeftArea: UIView!
    @IBOutlet weak var bottomLeftArea: UIView!
    
    
    @IBOutlet weak var colorDetectorView: UIView!
    
    
    var fileViewOrigin: CGPoint!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        roundAreaCorners(view: bottomLeftArea)
        roundAreaCorners(view: topLeftArea)
        roundAreaCorners(view: bottomRightArea)
        roundAreaCorners(view: topRightArea)
        
        addPanGesture(view: playImageView)
        fileViewOrigin = playImageView.frame.origin
        view.bringSubviewToFront(playImageView)
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
            if fileView.frame.intersects(bottomRightArea.frame) {
                print("intersected view: bottom right")
                colorDetectorView.backgroundColor = bottomRightArea.backgroundColor
                deleteView(view: fileView)
            } else if fileView.frame.intersects(topRightArea.frame) {
                print("intersected view: top right")
                colorDetectorView.backgroundColor = topRightArea.backgroundColor
                deleteView(view: fileView)
            } else if fileView.frame.intersects(bottomLeftArea.frame) {
                print("intersected view: bottom left")
                colorDetectorView.backgroundColor = bottomLeftArea.backgroundColor
                deleteView(view: fileView)
            } else if fileView.frame.intersects(topLeftArea.frame) {
                print("intersected view: top left")
                colorDetectorView.backgroundColor = topLeftArea.backgroundColor
                deleteView(view: fileView)
            }
            else {
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
        UIView.animate(withDuration: 0.3, animations: {
            view.alpha = 0.0
            self.returnViewToOrigin(view: view)
            view.alpha = 1.0
        })
        // haptic, play playlist
    }
    
    func roundAreaCorners(view: UIView){
        view.layer.masksToBounds = true
        view.layer.cornerRadius = view.bounds.width / 2
    }

}

