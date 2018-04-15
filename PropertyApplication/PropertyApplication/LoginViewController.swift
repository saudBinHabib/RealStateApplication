//
//  LoginViewController.swift
//  PropertyApplication
//
//  Created by Saud Bin Habib
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    @objc var userAuthenticated:Bool = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userAuthenticated = UserDefaults.standard.bool(forKey: "userAuthenticated");
        
        if(userAuthenticated)
        {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "afterLogin", sender: self);
            }
        }
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

    
    @IBAction func onSignInButtonClicked(_ sender: Any) {
        
        // validate credentials from the server
        let userEmail = userEmailTextField.text;
        let userPassword = userPasswordTextField.text;
        
        // Check for empty fields
        if((userEmail?.isEmpty)! || (userPassword?.isEmpty)!)
        {
            displayMyAlertMessage(userMessage: "All fields are required");
            return;
        }
        
        
        // POST request to server
        let hostAddress = ProjectConfigs.hostAddress;
        let myUrl = URL(string: "\(hostAddress)login");
        var request = URLRequest(url: myUrl!);
        request.httpMethod = "POST";
        let postString = "username=\(userEmail)&password=\(userPassword)"
        
        
        let jsonPostString: [String: Any] = ["username": userEmail ?? "", "password": userPassword ?? ""];
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonPostString)
        
        request.httpBody = jsonData;
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            print("call to server test 11");
            if error != nil
            {
                print("error=\(error)")
                return
            }
            
            print(response?.mimeType)
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                print (json)
                let status = json["success"] as? Bool
                if(status == true)
                {
                    if let data1 = json["data"] as? NSDictionary {
                        let userTypeId = data1["UserTypeId"] as? String
                        print("user type id :::::: \(userTypeId)")
                        UserDefaults.standard.set(true, forKey: "userAuthenticated");
                        UserDefaults.standard.set(userTypeId, forKey: "userTypeId")
                    }
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "afterLogin", sender: self);
                    }
                }
                else if(status == false)
                {
                    print (">>>>>>>>>>> in error block");
                    DispatchQueue.main.async {
                        self.displayMyAlertMessage(userMessage: "Invalid UserName or Password");
                    }
                    UserDefaults.standard.set(false, forKey: "userAuthenticated");
                    return;
                }
                else
                {
                    print ("Oder hier?????");
                }
//                if let parseJSON = json {
//                    let status = parseJSON["success"] as? String
//                    print("result::::::: \(status)")
//
//
//
//                    print("user type ::::: \(parseJSON["userTypeDescription"])")
//
//
//                }
//                else
//                {
//                    print ("hier");
//                }
            } catch {
                print("Error:::: ",error)
            }
            
            
        })
        
        task.resume();
    }
    
    @objc func displayMyAlertMessage(userMessage : String)
    {
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert);
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil);
        
        myAlert.addAction(okAction);
        
        self.present(myAlert, animated: true, completion: nil);
    }
    
}
