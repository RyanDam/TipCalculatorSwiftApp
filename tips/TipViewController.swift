//
//  ViewController.swift
//  tips
//
//  Created by Dam Vu Duy on 2/24/16.
//  Copyright © 2016 dotRStudio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var paperView: UIStackView!
    @IBOutlet weak var settingBarButton: UIBarButtonItem!
    @IBOutlet weak var topExtentPaperView: UIView!
    @IBOutlet weak var billAmong: UITextField!
    @IBOutlet weak var tipAmong: UILabel!
    @IBOutlet weak var totalAmong: UILabel!
    @IBOutlet weak var billPaperView: UIStackView!
    @IBOutlet weak var topBillPaperView: UIStackView!
    
    let defaultUser:NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        let index = defaultUser.integerForKey(SettingsViewController.INDEX_FOR_TIP_PERCENT)
        tipIndex = index
        onChangeBillAmong(billAmong)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupNavigation() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 245/255, green: 166/255, blue: 35/255, alpha: 1)
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }
    
    var tipIndex = 2
    let tipPercents = [0.1, 0.15, 0.18, 0.2, 0.22]
    let animationTrigger:CGFloat = 500
    let animationGap:CGFloat = 100
    var isAnimating = false
    
    
    @IBAction func onChangeBillAmong(sender: UITextField) {
        if let among = Double(sender.text!) {
            setAmong(among)
        }
        else {
            setAmong(0)
        }
    }

    func setAmong(among: Double) {
        let tipMoney = tipPercents[tipIndex]*among
        tipAmong.text = "$\(tipMoney) (\(tipPercents[tipIndex]*100)%)"
        totalAmong.text = "$\(tipMoney + among)"
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func onDrag(sender: UIPanGestureRecognizer) {
        if isAnimating { return }
        let velo = sender.velocityInView(self.billPaperView)
        if (velo.y > self.animationTrigger) {
            // darg down
            if (self.tipIndex > 0) {
                self.tipIndex = self.tipIndex - 1
                animationPaper(animationGap)
            }
        } else if (velo.y < -self.animationTrigger){
            // drag up
            if (self.tipIndex < tipPercents.count - 1) {
                self.tipIndex = self.tipIndex + 1
                animationPaper(-animationGap)
            }
        }
    }
    
    // Pull Animation handy method
    // gap < 0 to push up
    // gap > 0 to pull down
    func animationPaper(gap:CGFloat) {
        UIView.animateWithDuration(0.2, animations: {()->Void in
            self.paperView.frame.origin.y += gap
            self.isAnimating = true
            }, completion: { (_:Bool) -> Void in
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.paperView.frame.origin.y -= gap
                })
                self.onChangeBillAmong(self.billAmong)
                self.isAnimating = false
        })
    }
}

