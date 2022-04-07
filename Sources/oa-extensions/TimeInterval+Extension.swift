//
//  TimeInterval+Extension.swift
//  oa-extensions
//
//  Created by Osvaldo Pirrello on 06/04/22.
//  Copyright © 2022 OverApp. All rights reserved.
//

import Foundation

public extension TimeInterval {
    
    var workoutTime: String {
        hour>0 ? String(format:"%02dh%02d'%02d.%02d", hour, minute, second, millisecond/100) : String(format:"%02d'%02d.%02d", minute, second, millisecond/100)
    }
    
    var hoursMinuteSecondMS: String {
        String(format:"%02d:%02d:%02d", hour, minute, second)
    }
    
    var minuteSecondMS: String {
        String(format:"%d:%02d.%03d", minute, second, millisecond)
    }
    
    var hour: Int {
        Int((self / 3600).truncatingRemainder(dividingBy: 3600))
    }
    
    var minute: Int {
        Int((self / 60).truncatingRemainder(dividingBy: 60))
    }
    
    var second: Int {
        Int(truncatingRemainder(dividingBy: 60))
    }
    
    var millisecond: Int {
        Int((self * 1000).truncatingRemainder(dividingBy: 1000))
    }
    
}
