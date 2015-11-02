//
//  TimerView.swift
//  Tudora
//
//  Created by xiaoo_gan on 10/27/15.
//  Copyright © 2015 xiaoo_gan. All rights reserved.
//

import UIKit

class TimerView: UIView {

    var durationInseconds: CGFloat = 0.0
    var maxValue: CGFloat = 60.0
    var showRemaining = true
    
    let timerShapeLayer = CAShapeLayer()
    let secondShapeLayer = CAShapeLayer()
    var timeLabel = UILabel()
    override init(frame: CGRect) {
        timeLabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont(name: "HelveticaNeue-Thin", size: 80)
            label.textAlignment = .Center
            label.textColor = Theme.timerColor
            return label
        }()
        super.init(frame: frame)
        backgroundColor = UIColor.clearColor()
        layer.addSublayer(timerShapeLayer)
        layer.addSublayer(secondShapeLayer)
        addSubview(timeLabel)
        
        var constraints = [NSLayoutConstraint]()
        constraints.append(timeLabel.centerXAnchor.constraintEqualToAnchor(centerXAnchor))
        constraints.append(timeLabel.centerYAnchor.constraintEqualToAnchor(centerYAnchor))
        NSLayoutConstraint.activateConstraints(constraints)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func drawRect(rect: CGRect) {
        var percentage: CGFloat
        var dummyInt: Int
        if !showRemaining {
            dummyInt = Int(100000.0 * (1 - (durationInseconds - 1) / maxValue))
        } else {
            dummyInt = Int(100000.0 * (durationInseconds - 1) / maxValue)
        }
        percentage = CGFloat(dummyInt) / 100000.0
        
        let timerCenter = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect))
        let radius = rect.size.width / 2 - 10
        let startAngle = 3 * CGFloat(M_PI) / 2
        
        let timerRingPath = UIBezierPath(arcCenter: timerCenter, radius: radius, startAngle: startAngle, endAngle: startAngle - 0.001, clockwise: true)
        timerShapeLayer.fillColor = UIColor.clearColor().CGColor
        timerShapeLayer.strokeColor = Theme.timerColor.CGColor
        timerShapeLayer.lineWidth = 3
        timerShapeLayer.strokeEnd = percentage
        timerShapeLayer.path = timerRingPath.CGPath
        
        let totalMinutes = (maxValue - 1) / 60
        let dashLength = 2 * radius * CGFloat(M_PI) / totalMinutes
        timerShapeLayer.lineDashPattern = [dashLength - 2, 2]
        
        var secondsPercentage: CGFloat
        if showRemaining {
            secondsPercentage = (durationInseconds - 1) % 60.0
        } else {
            secondsPercentage = 60.0 - (durationInseconds - 1) % 60.0
        }
        let secondsRingPath = UIBezierPath(arcCenter: timerCenter, radius: radius - 4, startAngle: startAngle, endAngle: startAngle - 0.001, clockwise: true)
        secondShapeLayer.fillColor = UIColor.clearColor().CGColor
        secondShapeLayer.strokeColor = Theme.timerColor.CGColor
        secondShapeLayer.lineWidth = 1.0
        secondShapeLayer.strokeEnd = CGFloat(secondsPercentage) / 60.0
        secondShapeLayer.path = secondsRingPath.CGPath
        Theme.timerColor.set()
        
        let fullRingPath = UIBezierPath(arcCenter: timerCenter, radius: radius + 4, startAngle: startAngle, endAngle: startAngle - 0.001, clockwise: true)
        fullRingPath.lineWidth = 1.0
        fullRingPath.stroke()
        
        if !showRemaining {
            durationInseconds = maxValue - durationInseconds
        }
        let seconds = Int(durationInseconds % 60)
        let minutes = Int(durationInseconds / 60.0)
        let labelText = NSString(format: "%02d:%02d", minutes, seconds)
        timeLabel.text = labelText as String
        timeLabel.setNeedsDisplay()
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        showRemaining = !showRemaining
        setNeedsDisplay()
    }
}


