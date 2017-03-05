//
//  ViewController.swift
//  iaptesting
//
//  Created by Cyrus Chan on 5/2/2017.
//  Copyright © 2017 ckmobile.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var level2Button: UIButton!
    @IBOutlet weak var purchaseButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        
        let appDel = UIApplication.shared.delegate as! AppDelegate
        appDel.homeController = self
        
        let save = UserDefaults.standard
        if save.value(forKey: "Purchase") != nil {
            enableLevel2()
        }else{
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func enableLevel2(){
        level2Button.isEnabled = true
//        purchaseButton.isEnabled = false
//        purchaseButton.isHidden = true
    }

}

