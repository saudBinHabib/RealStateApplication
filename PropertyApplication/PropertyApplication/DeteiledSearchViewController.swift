//
//  DeteiledSearchViewController.swift
//  PropertyApplication
//
//  Created by Saad Abdullah Gondal on 4/2/17.
//  Copyright © 2017 Saad Abdullah Gondal. All rights reserved.
//

import UIKit

class DeteiledSearchViewController: UIViewController {

    
    @IBOutlet weak var apartmentTitle: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var zipcode: UITextField!
    @IBOutlet weak var rentFrom: UITextField!
    @IBOutlet weak var rentTo: UITextField!
    @IBOutlet weak var flatmatesFrom: UITextField!
    @IBOutlet weak var flatematesTo: UITextField!
    @IBOutlet weak var animals: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func searchResultsWithParams(_ sender: Any) {
        
//        let homeObj : HomePageTableViewController =  HomePageTableViewController();
//        
//        
//        homeObj.queryDetailedSearch(apartmentTitle: apartmentTitle.text!, address: address.text!, zipcode: zipcode.text!, rentFrom: rentFrom.text!, rentTo: rentTo.text!, flatmatesFrom: flatmatesFrom.text!, flatematesTo: flatematesTo.text!, animals: (animals.isOn ? "Y":"N"))
        
//        let homepageVC = storyboard?.instantiateViewController(withIdentifier: "HomePageTableViewController") as! HomePageTableViewController
//        //let value = propertyListings[indexPath.row]
        
      //  homepageVC.criteria = "Location"
        
        
        
        let crit : String = "?title=\(apartmentTitle.text!)&address=\(address.text!)&zipcode=\(zipcode.text!)&rentFrom=\(rentFrom.text!)&rentTo=\(rentTo.text!)&roomatesFrom=\(flatmatesFrom.text!)&roomatesTo=\(flatematesTo.text!)&animals=\(animals.isOn ? "Y":"N")"
        
        HomePageTableViewController.criteria = crit
        
//        self.navigationController?.pushViewController(homepageVC, animated: true)
        
//        performSegue(withIdentifier: "viewListings", sender: self)
       // return;
    }
    

}
