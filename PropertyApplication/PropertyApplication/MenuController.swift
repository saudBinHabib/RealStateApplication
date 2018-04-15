//
//  MenuController.swift
//  PropertyApplication
//
//  Created by Saud Bin Habib
//

import UIKit

class MenuController: UITableViewController {

    @objc var userAuthenticated:Bool = false;
    @objc var userTypeId:Int = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Post a Listing => Index: 2 ---> Need Landlord Login To Proceed
        // Profile & Postings => Index: 3 ---> Need Any Login to Proceed
        
        
        if(indexPath.row == 2 || indexPath.row == 3)
        {
            userAuthenticated = UserDefaults.standard.bool(forKey: "userAuthenticated");
            userTypeId = UserDefaults.standard.integer(forKey: "userTypeId");
            
            let userType:Int = userTypeId as Int
            
            // user needs to be authenticated for these two selections
            if(userAuthenticated)
            {
                // if POST A LISTING is selected then userTypeId should be 15
                if(indexPath.row == 2)
                {
                    if(userType != 15)
                    {
                        // Do not allow view this page
                        DispatchQueue.main.async {
                            self.displayMyAlertMessage(userMessage: "Only Landlord can Post Listings");
                        }
                        performSegue(withIdentifier: "viewListings", sender: self)
                        return;
                    }
                }
            }
            else
            {
                // authentication message
                DispatchQueue.main.async {
                    self.displayMyAlertMessage(userMessage: "Login before viewing this page");
                }
                performSegue(withIdentifier: "viewListings", sender: self)
                return;
            }
        }
    }
    
    @objc func displayMyAlertMessage(userMessage : String)
    {
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert);
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil);
        
        myAlert.addAction(okAction);
        
        self.present(myAlert, animated: true, completion: nil);
    }

}
