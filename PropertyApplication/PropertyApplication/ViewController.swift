//
//  ViewController.swift
//  PropertyApplication
//
//  Created by Saad Abdullah Gondal on 3/5/17.
//  Copyright © 2017 Saad Abdullah Gondal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        
        let authenticateUser = UserDefaults.standard.value(forKey: "showLogin") as? Bool;
        
        //let value = authenticateUser == "some" ? "false":authenticateUser;
        
        if authenticateUser == nil
        {
            self.performSegue(withIdentifier: "loginView", sender: self)
        }
        else if authenticateUser!
        {
            self.performSegue(withIdentifier: "loginView", sender: self)
        }
    }
    
    
    @IBAction func onLogoutButtonClicked(_ sender: Any) {
        
        UserDefaults.standard.setValue(false, forKey: "showLogin");
        UserDefaults.standard.synchronize();
        self.performSegue(withIdentifier: "loginView", sender: self);
    }
    

}

