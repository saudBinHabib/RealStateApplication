//
//  SignOutViewController.swift
//  PropertyApplication
//
//  Created by Saud Bin Habib
//

import UIKit

class SignOutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onSignOutButtonClicked(_ sender: Any) {
        
        UserDefaults.standard.set(false, forKey: "userAuthenticated")
        UserDefaults.standard.set(0, forKey: "userTypeId")
        
        //UserDefaults.resetStandardUserDefaults();
        
        print("Signing out.. userAuthenticated: \(UserDefaults.standard.value(forKey: "userAuthenticated"))")
        print("userTypeId \(UserDefaults.standard.value(forKey: "userTypeId"))")
        
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "afterLogout", sender: self);
        }
    }
}
