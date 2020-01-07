//
//  PlaylistSelectorTableViewController.swift
//  dogsled
//
//  Created by Mikalangelo Wessel on 1/5/20.
//  Copyright © 2020 Mikalangelo Wessel. All rights reserved.
//

import Foundation
import UIKit
import MediaPlayer

class PlaylistSelectorTableViewController: UITableViewController {
    
    var playlists:[MPMediaItemCollection] = []
    var currentActionView:ActionView? = nil
    var delegate: MainViewController? = nil
    
    override func viewDidLoad() {
        let myPlaylistQuery = MPMediaQuery.playlists()
        playlists = myPlaylistQuery.collections!
        print("Playlist count: \(playlists.count)")
        for playlist in playlists {
            print(playlist.value(forProperty: MPMediaPlaylistPropertyName)!)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return playlists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)

        cell.textLabel?.text = playlists[indexPath.row].value(forProperty: MPMediaPlaylistPropertyName)! as! String

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        delegate?.updateActionViewTitle(string: playlists[indexPath.row].value(forProperty: MPMediaPlaylistPropertyName)! as! String, tag: currentActionView!.tag)
        dismiss(animated: true, completion: nil)
    }
}
