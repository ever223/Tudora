//
//  ViewController.swift
//  Tudora
//
//  Created by xiaoo_gan on 10/17/15.
//  Copyright © 2015 xiaoo_gan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var aboutButton: UIButton!
    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet var timerButtons: [UIButton]!
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        view.backgroundColor = Theme.backgroundColor
        
        aboutButton.layer.cornerRadius = aboutButton.bounds.size.width / 2
        aboutButton.layer.borderWidth = 1.0
        aboutButton.layer.borderColor = Theme.buttonBorderColor.CGColor
        
        settingButton.layer.cornerRadius = aboutButton.bounds.size.width / 2
        settingButton.layer.borderWidth = 1.0
        settingButton.layer.borderColor = Theme.buttonBorderColor.CGColor
        
        for button in timerButtons {
            button.layer.cornerRadius = button.bounds.size.width / 2
            button.layer.borderWidth = 1.0
            button.layer.borderColor = Theme.buttonBorderColor.CGColor
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    @IBAction func pressedWorkButton(sender: UIButton) {
    }
    @IBAction func pressedBreakButton(sender: UIButton) {
    }
    @IBAction func pressedProcrastinateButton(sender: UIButton) {
    }
    
}

