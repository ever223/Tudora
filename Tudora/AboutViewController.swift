//
//  AboutViewController.swift
//  Tudora
//
//  Created by xiaoo_gan on 10/24/15.
//  Copyright © 2015 xiaoo_gan. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var avatorImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var githubButton: UIButton!
    @IBOutlet weak var weiboButton: UIButton!
    @IBOutlet weak var rateMeButton: UIButton!
    
    
    
    override func viewWillAppear(animated: Bool) {
        avatorImageView.layer.cornerRadius = avatorImageView.bounds.size.width / 2
        avatorImageView.clipsToBounds = true
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
