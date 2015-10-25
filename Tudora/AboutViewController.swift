//
//  AboutViewController.swift
//  Tudora
//
//  Created by xiaoo_gan on 10/24/15.
//  Copyright © 2015 xiaoo_gan. All rights reserved.
//

import UIKit
import SafariServices

class AboutViewController: UIViewController {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var avatorImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet var buttons: [UIButton]!
    @IBAction func dismiss(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: View Life Cycle
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        avatorImageView.layer.cornerRadius = avatorImageView.bounds.size.width / 2
        avatorImageView.clipsToBounds = true
        
        nameLabel.textColor = Theme.timerColor
        
        for button in buttons {
            button.layer.borderWidth = 1
            button.layer.borderColor = Theme.buttonBorderColor.CGColor
            button.layer.cornerRadius = 5
        }
        
        view.backgroundColor = Theme.backgroundColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Button Actions
    @IBAction func pressedButton(sender: UIButton) {
        switch sender.tag {
        case 0:
            let safariViewController = SFSafariViewController(URL: NSURL(string: "https://github.com/ever223/Tudora")!)
            navigationController?.pushViewController(safariViewController, animated: true)
        case 1:
            let safariViewController = SFSafariViewController(URL: NSURL(string: "http://weibo.com/xiaogan223")!)
            navigationController?.pushViewController(safariViewController, animated: true)
        case 2:
            let safariViewController = SFSafariViewController(URL: NSURL(string: "")!)
            navigationController?.pushViewController(safariViewController, animated: true)
        default:
            break
        }
    }
}
