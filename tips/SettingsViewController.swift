//
//  SettingsViewController.swift
//  tips
//
//  Created by Dam Vu Duy on 2/25/16.
//  Copyright © 2016 dotRStudio. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    static let INDEX_FOR_TIP_PERCENT = "TIP_INDEX"
    
    @IBOutlet weak var tipSegment: UISegmentedControl!

    let defaultUser:NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let index = defaultUser.integerForKey(SettingsViewController.INDEX_FOR_TIP_PERCENT)
        tipSegment.selectedSegmentIndex = index
    }
    
    @IBAction func onTipSegmentValueChanged(sender: UISegmentedControl) {
        let selected = sender.selectedSegmentIndex
        defaultUser.setInteger(selected, forKey: SettingsViewController.INDEX_FOR_TIP_PERCENT)
    }
    
    @IBAction func onDonePressed(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
