//
//  RegisterPageViewController.swift
//  PropertyApplication
//
//  Created by Saad Abdullah Gondal on 3/5/17.
//  Copyright © 2017 Saad Abdullah Gondal. All rights reserved.
//

import UIKit

class RegisterPageViewController: UIViewController {

    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var userTypeToggle: UISwitch!
    @IBOutlet weak var userTypeShowLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func onRegisterButtonClicked(_ sender: Any) {
        
        let userName = userNameTextField.text;
        let userEmail = userEmailTextField.text;
        let userPassword = userPasswordTextField.text;
        let userRepeatPassword = repeatPasswordTextField.text;
        var userType = ""
        
        // Check for empty fields
        if((userName?.isEmpty)! || (userEmail?.isEmpty)! || (userPassword?.isEmpty)! || (userRepeatPassword?.isEmpty)!)
        {
            displayMyAlertMessage(userMessage: "All fields are required");
            return;
        }
        
        // Check for passwords match
        if(userPassword != userRepeatPassword)
        {
            displayMyAlertMessage(userMessage: "Passwords do not match");
            return;
        }
        
        if(userTypeToggle.isOn)
        {
            userType = "student";
        }
        else
        {
            userType = "landlord";
        }
        
        // Post data to service
        let hostAddress = ProjectConfigs.hostAddress;
        let myUrl = URL(string: "\(hostAddress)/Property/ios_loginservice/registerUser");
        var request = URLRequest(url: myUrl!);
        request.httpMethod = "POST";
        
        let jsonPostString: [String: Any] = ["username": userName ?? "", "email": userEmail ?? "", "password": userPassword ?? "", "usertype": userType ];
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonPostString)
        
        request.httpBody = jsonData;   //postString.data(using: String.Encoding.utf8);
        
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            
            if error != nil
            {
                print("error=\(error)")
                return
            }
            
            
            // Validate JSON response before trying to parse
            
            print("call to server")
            
            do {
                //var err = NSError.self;
                //let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:Any]
                
                let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? Dictionary<String, Any>
                
                if let parseJSON = json {
                    
                    let status = parseJSON["status"] as? String
                    print("result: \(status)")
                    let messageToDisplay:String = parseJSON["message"] as! String;
                    
                    DispatchQueue.main.async {
                        let myAlert = UIAlertController(title: "Alert", message: messageToDisplay, preferredStyle: UIAlertControllerStyle.alert);
                        
                        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {action in self.dismiss(animated: true, completion: nil);
                        })
                        
                        myAlert.addAction(okAction);
                        self.present(myAlert, animated: true, completion: nil);
                    }
                    
                    
                }
            } catch {
                print("Error:::: ",error)
            }
            
            
        })
        
        task.resume();
        
    }
    
    func displayMyAlertMessage(userMessage : String)
    {
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert);
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil);
        
        myAlert.addAction(okAction);
        
        //self.presentedViewController(myAlert, dismiss(animated: true, completion: nil));
        
        self.present(myAlert, animated: true, completion: nil);
        
    }
    
    
    @IBAction func onSwitchToggled(_ sender: Any) {
        
        if(userTypeToggle.isOn)
        {
            userTypeShowLabel.text = "I am a Student"
        }
        else
        {
            userTypeShowLabel.text = "I am a Landlord"
        }
    }
    
}
