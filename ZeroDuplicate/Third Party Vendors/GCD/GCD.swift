//
//  GCD.swift
//  GCD
//
//  Created by Khurram Bilal Nawaz on 21/05/2017.
//  Copyright © 2017 AcclivousByte. All rights reserved.
//

import Foundation

var QueueBundleID = "com.Rapidzz.gcd"

public enum GCGThreadType {
    case Main
    case High
    case Default
    case Low
    case Background
}
//ca-app-pub-4964284666734851~6096651948

class GCD {
    
//    yaship lighting
    //    in.co.shuklarahul.ZeroDuplicate
    static func async(_ thread: GCGThreadType, delay: Double = 0.0, execute:@escaping () -> Void) {
        
        let dispatchTime = DispatchTime.now()+delay
        
        if thread == .Main {
            DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: execute)
        }else if thread == .Background {
            let queue = DispatchQueue(label: QueueBundleID, qos: .background)
            queue.asyncAfter(deadline: dispatchTime, execute: execute)
        }else if thread == .Default {
            let queue = DispatchQueue(label: QueueBundleID, qos: .default)
            queue.asyncAfter(deadline: dispatchTime, execute: execute)
        }else if thread == .High {
            let queue = DispatchQueue(label: QueueBundleID, qos: .userInteractive)
            queue.asyncAfter(deadline: dispatchTime, execute: execute)
        }else if thread == .Low{
            let queue = DispatchQueue(label: QueueBundleID, qos: .unspecified)
            queue.asyncAfter(deadline: dispatchTime, execute: execute)
        }
    }
}
