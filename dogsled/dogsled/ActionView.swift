//
//  ActionView.swift
//  dogsled
//
//  Created by Mikalangelo Wessel on 1/5/20.
//  Copyright © 2020 Mikalangelo Wessel. All rights reserved.
//

import Foundation
import UIKit

class ActionView: UIView {
    
    lazy var headerTitle: UILabel = {
      let headerTitle = UILabel(frame: CGRect(x: 0, y: 50, width: 300, height: 40))
      headerTitle.font = UIFont.systemFont(ofSize: 22, weight: .medium)
      headerTitle.text = "Hold to set Playlist"
      headerTitle.textAlignment = .center
      return headerTitle
    }()
    
    lazy var headerView: UIView = {
      let headerView = UIView(frame: CGRect(x: 0, y: 50, width: 300, height: 40))
      headerView.addSubview(headerTitle)
      return headerView
    }()
    
    //initWithFrame to init view from code
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    //initWithCode to init view from xib or storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    //common func to init our view
    private func setupView() {
        addSubview(headerView)
    }
    
    func getHeaderTitle(view: ActionView) -> String {
        return view.headerTitle.text!
    }
}
