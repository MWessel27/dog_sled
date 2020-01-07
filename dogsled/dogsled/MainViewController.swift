//
//  ViewController.swift
//  dogsled
//
//  Created by Mikalangelo Wessel on 1/5/20.
//  Copyright © 2020 Mikalangelo Wessel. All rights reserved.
//

import UIKit
import MediaPlayer

class MainViewController: UIViewController {
    
    @IBOutlet weak var playImageView: UIImageView!
    
    @IBOutlet weak var bottomRightArea: ActionView!
    @IBOutlet weak var topRightArea: ActionView!
    @IBOutlet weak var topLeftArea: ActionView!
    @IBOutlet weak var bottomLeftArea: ActionView!
    
    
    @IBOutlet weak var colorDetectorView: UIView!
    
    
    var fileViewOrigin: CGPoint!
    
    var lastSelectedView:ActionView? = nil
    var playlists:[MPMediaItemCollection] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let status = MPMediaLibrary.authorizationStatus()
        switch status {
        case .authorized:
            let myPlaylistQuery = MPMediaQuery.playlists()
            playlists = myPlaylistQuery.collections!
            print("Playlist count: \(playlists.count)")
            for playlist in playlists {
                print(playlist.value(forProperty: MPMediaPlaylistPropertyName)!)
            }
            break
        case .notDetermined:
            MPMediaLibrary.requestAuthorization() { status in
                if status == .authorized {
                    DispatchQueue.main.async {
                    }
                }
            }
        default:
            break
        }
        
        roundAreaCorners(view: bottomLeftArea)
        roundAreaCorners(view: topLeftArea)
        roundAreaCorners(view: bottomRightArea)
        roundAreaCorners(view: topRightArea)
        
        addPanGesture(view: playImageView)
        fileViewOrigin = playImageView.frame.origin
        view.bringSubviewToFront(playImageView)
    }
    
    func addLongPressGesture(view: ActionView) {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(MainViewController.handleLongPress(sender:)))
        view.addGestureRecognizer(longPress)
    }
    
    @objc func handleLongPress(sender: UILongPressGestureRecognizer) {
        print("detected long press")
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        lastSelectedView = sender.view as? ActionView
        performSegue(withIdentifier: "showOptions", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("** Test")
        let nextViewController = segue.destination as? PlaylistSelectorTableViewController
        nextViewController?.currentActionView = lastSelectedView
        nextViewController?.delegate = self
    }

    func addPanGesture(view: UIView) {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(MainViewController.handlePan(sender:)))
        view.addGestureRecognizer(pan)
        
    }
    
    @objc func handlePan(sender: UIPanGestureRecognizer) {
        
        let fileView = sender.view!
        
        switch sender.state {
        case .began:
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
        case .changed:
            moveViewWithPan(view: fileView, sender: sender)
            
        case .ended:
            let generator = UINotificationFeedbackGenerator()
            if fileView.frame.intersects(bottomRightArea.frame) {
                generator.notificationOccurred(.success)
                print("intersected view: bottom right")
                colorDetectorView.backgroundColor = bottomRightArea.backgroundColor
                
                playActionViewPlaylist(view: bottomRightArea)
                
                deleteView(view: fileView)
            } else if fileView.frame.intersects(topRightArea.frame) {
                generator.notificationOccurred(.success)
                print("intersected view: top right")
                colorDetectorView.backgroundColor = topRightArea.backgroundColor
                
                playActionViewPlaylist(view: topRightArea)
                
                deleteView(view: fileView)
            } else if fileView.frame.intersects(bottomLeftArea.frame) {
                generator.notificationOccurred(.success)
                print("intersected view: bottom left")
                colorDetectorView.backgroundColor = bottomLeftArea.backgroundColor
                
                playActionViewPlaylist(view: bottomLeftArea)
                
                deleteView(view: fileView)
            } else if fileView.frame.intersects(topLeftArea.frame) {
                generator.notificationOccurred(.success)
                print("intersected view: top left")
                colorDetectorView.backgroundColor = topLeftArea.backgroundColor
                
                playActionViewPlaylist(view: topLeftArea)
                
                deleteView(view: fileView)
            }
            else {
                generator.notificationOccurred(.error)
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
    }
    
    func roundAreaCorners(view: UIView){
        view.layer.masksToBounds = true
        view.layer.cornerRadius = view.bounds.width / 2
        addLongPressGesture(view: view as! ActionView)
    }
    
    func updateActionViewTitle(string: String, tag: Int) {
        print("Update \(tag) with \(string)")
        if let subView:ActionView = view.viewWithTag(tag) as? ActionView {
            subView.headerTitle.text = string
        }
    }
    
    func playActionViewPlaylist(view: ActionView) {
        let musicPlayer = MPMusicPlayerController.applicationQueuePlayer
        let myMediaQuery = MPMediaQuery.songs()
        let predicateFilter = MPMediaPropertyPredicate(value: view.headerTitle.text, forProperty: MPMediaPlaylistPropertyName)
        myMediaQuery.filterPredicates = NSSet(object: predicateFilter) as? Set<MPMediaPredicate>
        musicPlayer.setQueue(with: myMediaQuery)
        musicPlayer.play()
    }
}

