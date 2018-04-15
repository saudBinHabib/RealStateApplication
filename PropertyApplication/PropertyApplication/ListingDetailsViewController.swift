//
//  ListingDetailsViewController.swift
//  PropertyApplication
//
//  Created by Saud Bin Habib
//

import UIKit

class ListingDetailsViewController: UIViewController {

    
    @IBOutlet weak var listingTitle: UILabel!
    @objc var selectedTitle:String?
    @IBOutlet weak var listingImage: UIImageView!
    @objc var selectedImage:UIImage?
    var propertyListingObj : PropertyListing! = PropertyListing()
    
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var zipcode: UILabel!
    @IBOutlet weak var rent: UILabel!
    @IBOutlet weak var roomates: UILabel!
    @IBOutlet weak var animals: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        listingTitle.text = "";
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if let myTitle = selectedTitle
        {
            listingTitle.text = myTitle;
        }
        if selectedImage != nil
        {
            listingImage.image = selectedImage
        }
        
        address.text = "Address: \(propertyListingObj.propertyAddress)"
        zipcode.text = "Zip Code: \(propertyListingObj.propertyZipCode)"
        rent.text = "Rent: \(propertyListingObj.propertyRent)"
        roomates.text = "Roomates: \(propertyListingObj.propertyRoomates)"
        if(propertyListingObj.propertyAnimals == "Y")
        {
            animals.text = "Animals Allowed: Yes"
        }
        else
        {
            animals.text = "Animals Allowed: No"
        }
        
    }
    
}
