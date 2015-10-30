//
//  ViewController.swift
//  Tudora
//
//  Created by xiaoo_gan on 10/17/15.
//  Copyright © 2015 xiaoo_gan. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {

    @IBOutlet weak var aboutButton: UIButton!
    @IBOutlet weak var settingButton: UIButton!
    
    @IBOutlet weak var workButton: UIButton!
    @IBOutlet weak var breakButton: UIButton!
    
    @IBOutlet weak var procrastinationButton: UIButton!
    
    @IBOutlet weak var timerView: TimerView!
    
    private var currentType = TimerType.Idle
    private var timer: NSTimer?
    private var endDate: NSDate?
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        view.backgroundColor = Theme.backgroundColor
        
        aboutButton.layer.cornerRadius = aboutButton.bounds.size.width / 2
        aboutButton.layer.borderWidth = 1.0
        aboutButton.layer.borderColor = Theme.buttonBorderColor.CGColor
        
        settingButton.layer.cornerRadius = aboutButton.bounds.size.width / 2
        settingButton.layer.borderWidth = 1.0
        settingButton.layer.borderColor = Theme.buttonBorderColor.CGColor
        
        workButton.layer.cornerRadius = workButton.bounds.size.width / 2
        workButton.layer.borderWidth = 1.0
        workButton.layer.borderColor = Theme.buttonBorderColor.CGColor
        
        procrastinationButton.layer.cornerRadius = procrastinationButton.bounds.size.width / 2
        procrastinationButton.layer.borderWidth = 1.0
        procrastinationButton.layer.borderColor = Theme.buttonBorderColor.CGColor
        
        breakButton.layer.cornerRadius = breakButton.bounds.size.width / 2
        breakButton.layer.borderWidth = 1.0
        breakButton.layer.borderColor = Theme.buttonBorderColor.CGColor
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    @IBAction func pressedWorkButton(sender: UIButton) {
        guard currentType != .Work
            else {
                showAlert()
                return
        }
        startTimerWithType(.Work)
    }
    @IBAction func pressedBreakButton(sender: UIButton) {
        guard currentType != .Break
            else {
                showAlert()
                return
        }
        startTimerWithType(.Break)
    }
    @IBAction func pressedProcrastinateButton(sender: UIButton) {
        guard currentType != .Procrastination
            else {
                showAlert()
                return
        }
        startTimerWithType(.Procrastination)
    }
    
    private func setDuration(duration: CGFloat, maxValue: CGFloat) {
        timerView.durationInseconds = duration
        timerView.maxValue = maxValue
        timerView.setNeedsDisplay()
    }
    
    private func setUIModelForTimerType(timerType: TimerType) {
        UIView.animateWithDuration(0.3, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: [], animations: { () -> Void in
            switch timerType {
            case .Work:
                self.set(self.workButton, enabled: true)
                self.set(self.breakButton, enabled: false)
                self.set(self.procrastinationButton, enabled: false)
            case .Break:
                self.set(self.workButton, enabled: false)
                self.set(self.breakButton, enabled: true)
                self.set(self.procrastinationButton, enabled: false)
            case .Procrastination:
                self.set(self.workButton, enabled: false)
                self.set(self.breakButton, enabled: false)
                self.set(self.procrastinationButton, enabled: true)
            default:
                self.set(self.workButton, enabled: true)
                self.set(self.breakButton, enabled: true)
                self.set(self.procrastinationButton, enabled: true)
            }
            }, completion: nil)
    }
    private func set(button: UIButton, enabled: Bool) {
        if enabled {
            button.enabled = true
            button.alpha = 1.0
        } else {
            button.enabled = false
            button.alpha = 0.3
        }
    }
    private func startTimerWithType(timerType: TimerType) {
        setDuration(0, maxValue: 1)
        var typeName: String
        switch timerType {
        case .Work:
            currentType = .Work
            typeName = "Work"
        case .Break:
            currentType = .Break
            typeName = "Break"
        case .Procrastination:
            currentType = .Procrastination
            typeName = "Procrastination"
        default:
            currentType = .Idle
            typeName = "None"
            resetTimer()
        }
        setUIModelForTimerType(currentType)
        
        let seconds = NSUserDefaults.standardUserDefaults().integerForKey(timerType.rawValue)
        endDate = NSDate(timeIntervalSinceNow: NSTimeInterval(seconds))
        let endTimestamp = floor(endDate!.timeIntervalSince1970)
        
        NSUserDefaults.standardUserDefaults().setDouble(endTimestamp, forKey: "date")
        NSUserDefaults.standardUserDefaults().setInteger(seconds, forKey: "maxValue")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        
        timer?.invalidate()
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "updateTimerLabel:", userInfo: ["timerType": seconds], repeats: true)
        
    }
    private func updateTimerLabel(sender: NSTimer) {
        var totoalNumberOfSeconds: CGFloat
        if let type = (sender.userInfo as! NSDictionary)["timerType"] as? Int {
            totoalNumberOfSeconds = CGFloat(type)
        } else {
            assert(false, "不会发生")
            totoalNumberOfSeconds = -1.0
        }
        let timeInterval = CGFloat(endDate!.timeIntervalSinceNow)
        if timeInterval < 0 {
            resetTimer()
            if timeInterval > -1 {
                AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
            }
            setDuration(0, maxValue: 1)
            return
        }
        setDuration(timeInterval, maxValue: totoalNumberOfSeconds)
    }
    private func resetTimer() {
        timer?.invalidate()
        timer = nil
        currentType = .Idle
        setUIModelForTimerType(currentType)
        
        NSUserDefaults.standardUserDefaults().removeObjectForKey("date")
        NSUserDefaults.standardUserDefaults().synchronize()
        
    }
}
// MARK: - ALERT
extension ViewController {
    private func showAlert() {
        var msg = "停止"
        switch currentType {
        case .Work:
            msg += "工作计时器？"
        case .Break:
            msg += "休息计时器？"
        case .Procrastination:
            msg += "延时？"
        default:
            break
        }
        let alertController = UIAlertController(title: "停止？", message: msg, preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "取消", style: .Cancel) { (action) -> Void in
            print("取消")
        }
        alertController.addAction(cancelAction)
        let stopAction = UIAlertAction(title: "停止", style: .Default) { (action) -> Void in
            self.startTimerWithType(.Idle)
        }
        alertController.addAction(stopAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
}

