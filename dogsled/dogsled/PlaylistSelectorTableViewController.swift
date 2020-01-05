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
    
    let mp = MPMusicPlayerController.systemMusicPlayer
    var playlists:[MPMediaItemCollection] = []
    var selectedAction:String = ""
    
    override func viewDidLoad() {
        let myPlaylistQuery = MPMediaQuery.playlists()
        playlists = myPlaylistQuery.collections!
        print("Playlist count: \(playlists.count)")
        for playlist in playlists {
                    print(playlist.value(forProperty: MPMediaPlaylistPropertyName)!)

        //            let songs = playlist.items
        //            for song in songs {
        //                let songTitle = song.value(forProperty: MPMediaItemPropertyTitle)
        //                print("\t\t", songTitle!)
        //            }
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

        print("\(#function) --- section = \(indexPath.section), row = \(indexPath.row)")

        cell.textLabel?.text = playlists[indexPath.row].value(forProperty: MPMediaPlaylistPropertyName)! as! String

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        dismiss(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let mainViewController = segue.destination as? MainViewController,
            let index = tableView.indexPathForSelectedRow?.row
            else {
                return
        }
        print(index)
    }
}
