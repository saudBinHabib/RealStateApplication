//
//  PostListingViewController.swift
//  PropertyApplication
//
//  Created by Saad Abdullah Gondal on 3/10/17.
//  Copyright © 2017 Saad Abdullah Gondal. All rights reserved.
//

import UIKit

class PostListingViewController: UIViewController {

    
    @IBOutlet weak var menuButton: UIBarButtonItem!
        
    // Property Title
    @IBOutlet weak var propertyTitle: UITextField!
    
    // Property Description
    @IBOutlet weak var propertyDescription: UITextField!
    
    // Rental Address
    @IBOutlet weak var rentalAddress: UITextField!
    
    // Zip Code
    @IBOutlet weak var zipCode: UITextField!
    
    // Monthly Rent
    @IBOutlet weak var monthlyRent: UITextField!
    
    // Number of Occupants
    @IBOutlet weak var numberOfOccupants: UITextField!
    
    // Animals Allowed? - Boolean
    @IBOutlet weak var animalsAllowed: UISwitch!
    
    // Pictures
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onProceedClicked(_ sender: Any) {
        
        
        let title = propertyTitle.text
        let description = propertyDescription.text
        let address = rentalAddress.text
        let zip = zipCode.text
        let rent = monthlyRent.text
        let occupants = numberOfOccupants.text
        let animals = animalsAllowed.isOn
        
        // POST request to server
        let hostAddress = ProjectConfigs.hostAddress;
        let myUrl = URL(string: "\(hostAddress)/Property/ios_postListings/submitPost");
        var request = URLRequest(url: myUrl!);
        request.httpMethod = "POST";
        
        let jsonPostString: [String: Any] = ["title": title ?? "", "description": description ?? "", "address": address ?? "", "zipCode": zip ?? "", "rent": rent ?? "", "occupants": occupants ?? "", "animals": animals];
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonPostString)
        
        request.httpBody = jsonData;
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            print("call to server test 1");
            if error != nil
            {
                print("error=\(error)")
                return
            }
            
            
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? Dictionary<String, Any>
                
                if let parseJSON = json {
                    let status = parseJSON["status"] as? String
                    print("result: \(status)")
                    
                    
                    if(status == "Success")
                    {
                        print(">>>>>> show protected");
                        UserDefaults.standard.setValue(false, forKey: "showLogin"); // afterLogin
                        UserDefaults.standard.synchronize();
                        
                        //self.dismiss(animated: true, completion: nil);
                        
                        DispatchQueue.main.async {
                            let myAlert = UIAlertController(title: "Alert", message: "Property Posted Successfully", preferredStyle: UIAlertControllerStyle.alert);
                            
                            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {action in self.dismiss(animated: true, completion: nil);})
                            
                            myAlert.addAction(okAction);
                            
                            self.present(myAlert, animated: true, completion: nil);
                        }
                        
                    }
                    else{
                        print(">>>>>> Error occurred");
                        
                        DispatchQueue.main.async {
                            let myAlert = UIAlertController(title: "Alert", message: "Error in posting", preferredStyle: UIAlertControllerStyle.alert);
                            
                            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
                            
                            myAlert.addAction(okAction);
                            
                            self.present(myAlert, animated: true, completion: nil);
                        }
                    }
                    
                    
                    
                    
                    
                }
            } catch {
                print("Error:::: ",error)
            }
            
            
        })
        
        task.resume();
    }
    
}
