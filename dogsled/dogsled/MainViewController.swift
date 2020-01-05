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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        topLeftCircleImageView.layer.masksToBounds = true
        topLeftCircleImageView.layer.cornerRadius = topLeftCircleImageView.bounds.width / 2
    }


}

