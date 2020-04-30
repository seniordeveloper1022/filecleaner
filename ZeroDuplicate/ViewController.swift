//
//  ViewController.swift
//  ZeroDuplicate
//
//  Created by trivalent on 13/02/19.
//  Copyright © 2019 trivalent. All rights reserved.
//

import UIKit
import MBCircularProgressBar

//start scan view controller
class ViewController: UIViewController {
    @IBOutlet weak var appImageView: UIImageView!
    @IBOutlet weak var appTitle: UILabel!
    @IBOutlet weak var appSubTitle: UILabel!
    @IBOutlet weak var btnScanSimilar: UIButton!
    @IBOutlet weak var btnScanExact: UIButton!
    @IBOutlet weak var searchProgress: MBCircularProgressBarView!
    @IBOutlet weak var btnStartStopScan: UILabel!
    @IBOutlet weak var searchInfoContainer: UIView!
    @IBOutlet weak var duplicateCountText: UILabel!
    @IBOutlet weak var scanTimeText: UILabel!
    @IBOutlet weak var btnFixDuplicates: UIButton!
    
    
    private static let SCAN_MODE_EXACT  = 1;
    private static let SCAN_MODE_SIMILAR = 2;
    private var currentState = 0;
    
    private var scanMode: Int = 0;
    
    override func viewDidLoad() {
        appTitle.text = NSLocalizedString(Strings.SELECT_SCAN_MODE, comment: "")
        appSubTitle.text = NSLocalizedString(Strings.SELECT_SCAN_DETAIL, comment: "")
        searchInfoContainer.isHidden = true
        btnScanSimilar.addTarget(self, action: #selector(scanSimilar), for: .touchUpInside)
        btnScanExact.addTarget(self, action: #selector(scanExact), for: .touchUpInside)
        btnStartStopScan.isUserInteractionEnabled = true
        btnStartStopScan.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(startStopScan)))
    }
    
    @objc func startStopScan(){
        print("Start scan or Stop scan");
        currentState = (currentState + 1) % 3
        updateButtonText();
    }
    
    @objc func scanSimilar() {
        self.scanMode = ViewController.SCAN_MODE_EXACT;
        self.startScan()
    }
    
    @objc func scanExact() {
        self.scanMode = ViewController.SCAN_MODE_SIMILAR;
        self.startScan()
    }
    
    func startScan() {
        print("Asked to start scan with mode = \(scanMode)")
        hideOnScanStart()
    }
    
    func updateButtonText() {
        var labelText = "";
        switch currentState {
        case 1:
            labelText = "Stop"
            break;
        case 2:
            labelText = "Re-Scan"
            break;
        default:
            labelText = "Start"
        }
        btnStartStopScan.text = labelText;
    }
    
    func hideOnScanStart() {
        UIView.transition(with: btnScanExact, duration: 5000, options: UIView.AnimationOptions.curveLinear, animations: {
            self.appImageView.isHidden = true
            self.btnScanExact.isHidden = true
            self.btnScanSimilar.isHidden = true
            self.appTitle.isHidden = true
            self.appSubTitle.isHidden = true
            self.searchProgress.isHidden = false
        }, completion: nil)
    }
}

