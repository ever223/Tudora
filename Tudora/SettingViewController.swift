//
//  SettingViewController.swift
//  Tudora
//
//  Created by xiaoo_gan on 10/25/15.
//  Copyright © 2015 xiaoo_gan. All rights reserved.
//

import UIKit

enum TimerType : String {
    case Work = "Work"
    case Break = "Break"
    case Procrastination = "Procrastination"
    case Idle = "Idle"
}

class SettingViewController: UIViewController {
    @IBOutlet weak var workView: UIView!
    @IBOutlet weak var breakView: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var workDurationValueLabel: UILabel!
    @IBOutlet weak var breakDurationValueLabel: UILabel!

    let userDefault = NSUserDefaults.standardUserDefaults()
    private let markerView = UIView()
    
    let workTimes = [10, 15, 20, 25, 30, 35, 40, 45, 50, 55]
    let breakTimes = [1, 2, 5, 10]
    
    var selectedTimerType: TimerType = .Work
    private var currentWorkDuration = NSUserDefaults.standardUserDefaults().integerForKey(TimerType.Work.rawValue) / 60
    private var currentBreakDuration = NSUserDefaults.standardUserDefaults().integerForKey(TimerType.Break.rawValue) / 60
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = Theme.backgroundColor
        
        workView.layer.cornerRadius = 5
        workView.backgroundColor = Theme.backgroundColor
        
        breakView.layer.cornerRadius = 5
        breakView.backgroundColor = Theme.backgroundColor
        
        markerView.layer.cornerRadius = 5
        markerView.backgroundColor = UIColor.yellowColor()
        markerView.layer.zPosition = -1
        view.addSubview(markerView)
        
        setWorkDurationValue("\(currentWorkDuration) 分钟")
        setBreakDurationValue("\(currentBreakDuration) 分钟")
        
        var row = 0
        for (index, value) in workTimes.enumerate() {
            if currentWorkDuration == value {
                row = index
                break
            }
        }
        pickerView.selectRow(row, inComponent: 0, animated: false)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        moveMarkerToView(workView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pickerView.dataSource = self
        pickerView.delegate = self
        
        let workgestureRecongnizer = UITapGestureRecognizer(target: self, action: "moveMarker:")
        workView.addGestureRecognizer(workgestureRecongnizer)
        
        let breakgestureRecongnizer = UITapGestureRecognizer(target: self, action: "moveMarker:")
        breakView.addGestureRecognizer(breakgestureRecongnizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setDurationString(s: String) {
        switch selectedTimerType {
        case .Work:
            setWorkDurationValue(s)
        default:
            setBreakDurationValue(s)
        }
    }
    func setBreakDurationValue(s: String) {
        breakDurationValueLabel.text = s
    }
    func setWorkDurationValue(s: String) {
        workDurationValueLabel.text = s
    }
    
    func moveMarkerToView(view: UIView) {
        if CGRectContainsPoint(workView.frame, view.center) {
            selectedTimerType = .Work
        } else {
            selectedTimerType = .Break
        }
        UIView.animateWithDuration(0.3, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 5.0, options: [], animations: { () -> Void in
            self.markerView.frame = CGRectInset(view.frame, -3, -3)
            }, completion: nil)
    }
    func moveMarker(sender: UITapGestureRecognizer) {
        moveMarkerToView(sender.view!)
        pickerView.reloadAllComponents()
        
        var times: [Int]
        var currentDuration: Int
        switch selectedTimerType {
        case .Work:
            times = workTimes
            currentDuration = currentWorkDuration
        default:
            times = breakTimes
            currentDuration = currentBreakDuration
        }
        
        var row = 0
        for (index, value) in times.enumerate() {
            if currentDuration == value {
                row = index
                break
            }
        }
        pickerView.selectRow(row, inComponent: 0, animated: false)
    }
    
    @IBAction func doneButton(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
extension SettingViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var minutes = 0
        switch selectedTimerType {
        case .Work:
            minutes = workTimes[row]
        default:
            minutes = breakTimes[row]
        }
        let attributedTitle = NSAttributedString(string: "\(minutes) 分钟", attributes: [NSForegroundColorAttributeName : UIColor.yellowColor()])
        return attributedTitle
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch selectedTimerType {
        case .Work:
            return workTimes.count
        default :
            return breakTimes.count
        }
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var minutes = 0
        var timerType: TimerType = .Work
        switch selectedTimerType {
        case .Work:
            minutes = workTimes[row]
            currentWorkDuration = minutes
        default:
            minutes = breakTimes[row]
            currentBreakDuration = minutes
            timerType = .Break
        }
        setDurationString("\(minutes) 分钟")
        let seconds = minutes * 60 + 1
        NSUserDefaults.standardUserDefaults().setInteger(seconds, forKey: timerType.rawValue)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
}