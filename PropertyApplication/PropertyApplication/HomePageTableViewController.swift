//
//  HomePageViewControllerTableTableViewController.swift
//  PropertyApplication
//
//  Created by Saad Abdullah Gondal on 3/8/17.
//  Copyright © 2017 Saad Abdullah Gondal. All rights reserved.
//

import UIKit

class HomePageTableViewController: UITableViewController, UISearchResultsUpdating {
    
    struct test
    {
        var title: String = ""
        var image:UIImage
    }
    
    var testArray:Array<test>?
    
    var propertyListings = [test]()
    var propertyImages = [String]()
    var propertyDesc = [PropertyListing]()
    
    var searchController : UISearchController!
    var resultsController = UITableViewController()
    var filteredPropertyListings = [test]()
    var filteredPropertyImages = [String]()
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var searchButton: UIBarButtonItem!
    @IBOutlet var myTableView: UITableView!
    
    @IBOutlet weak var image: UIImageView!
    
    static var criteria : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if(HomePageTableViewController.criteria == nil || HomePageTableViewController.criteria == "")
        {
            getPropertyListingsWithCount()
        }
        else
        {
            queryDetailedSearch(criteria: HomePageTableViewController.criteria!)
        }
        
        
        self.resultsController.tableView.dataSource = self
        
        self.resultsController.tableView.delegate = self
        
        self.searchController = UISearchController(searchResultsController: self.resultsController)
        self.tableView.tableHeaderView = self.searchController.searchBar
        self.searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = false
        
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            searchButton.target = revealViewController()
            searchButton.action = #selector(SWRevealViewController.rightRevealToggle(_:))
            
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
//        DispatchQueue.main.async {
//            self.myTableView.reloadData()
//        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        DispatchQueue.main.async {
                        self.myTableView.reloadData()
                    }
        
    }
    
    func getAllPropetyListings()
    {
        // POST request to server
        let hostAddress = ProjectConfigs.hostAddress;
        let myUrl = URL(string: "\(hostAddress)/Property/ios_loginservice/signInUser");
        var request = URLRequest(url: myUrl!);
        request.httpMethod = "GET";
        
        let jsonPostString: [String: Any] = ["SearchType": "All"];
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonPostString)
        
        request.httpBody = jsonData;
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            print("call to server test 1 :: HomePage");
            if error != nil
            {
                print("error=\(error)")
                return
            }
            
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? Dictionary<String, Any>
                
                if let parseJSON = json {
                    let status = parseJSON["status"] as? String
                    print("result::::::: \(status)")
                    
                    let userTypeId = parseJSON["userTypeId"] as? String
                    print("user type id :::::: \(userTypeId)")
                    
                    print("user type ::::: \(parseJSON["userTypeDescription"])")
                    
                    if(status == "Success")
                    {
                        
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: "afterLogin", sender: self);
                            
                            
                        }
                        
                        UserDefaults.standard.set(true, forKey: "userAuthenticated");
                        UserDefaults.standard.set(userTypeId, forKey: "userTypeId")
                        
                    }
                    else if(status == "Error")
                    {
                        print (">>>>>>>>>>> in error block");
                        return;
                    }
                    else
                    {
                        print ("Oder hier?????");
                    }
                }
                else
                {
                    print ("hier");
                }
            } catch {
                print("Error:::: ",error)
            }
            
            
        })
        
        task.resume();
        
        
        
    }
    
    func getPropertyListingsWithCount()
    {
        let scriptUrl = ProjectConfigs.hostAddress + ProjectConfigs.getPropertyListingsWithCount + "/?count=10";
        let myUrl = URL(string: scriptUrl)
        var request = URLRequest(url: myUrl! as URL)
        request.httpMethod = "GET"
        
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if error != nil
            {
                print("error=\(error)")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as? Array<Any>
                

                if let parseJSON = json {
                    
                    var propertyListingObj : PropertyListing! = PropertyListing()
                    
                    
                    var count = 11;
                  
                    for item in parseJSON as! [[String:Any]]
                    {
                        propertyListingObj = PropertyListing()
                        let title = item["TITLE"]! as! String
                        let address = item["ADDRESS"]! as! String
                        let zipcode = item["ZIP_CODE"]! as! String
                        let rent = item["PRICE"]! as! String
                        let roomates = item["NUMBER_OCCUPANTS"]! as! String
                        let animals = item["IS_PET_ALLOWED"]! as! String
                        
                        var item : test;
                        
                        if(count > 1)
                        {
                            //self.propertyImages.append("apartments\(count)")
                            //item.image = UIImage.init(named: "apartments\(count)")!
                            item = test(title: title, image: UIImage.init(named: "apartments\(count)")!)
                            count -= 1;
                        }
                        else
                        {
                            //self.propertyImages.append("apartments\(count)")
                            //item.image = UIImage.init(named: "apartments\(count)")!
                            item = test(title: title, image: UIImage.init(named: "apartments\(count)")!)
                            count = 11;
                        }
                        
                        self.propertyListings.append(item)
                        
                        propertyListingObj.propertyTitle = title
                        propertyListingObj.propertyAddress = address
                        propertyListingObj.propertyZipCode = zipcode
                        propertyListingObj.propertyRent = rent
                        propertyListingObj.propertyRoomates = roomates
                        propertyListingObj.propertyAnimals = animals
                        
                        self.propertyDesc.append(propertyListingObj)
                    }
                    
                    DispatchQueue.main.async {
                        self.myTableView.reloadData()
                    }
                    
                }
                else
                {
                    print ("hier");
                }
            } catch {
                print("Error:::: ",error.localizedDescription)
            }
            
            
        })
        
        task.resume();
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        // Filter through the table
        
        self.filteredPropertyListings = self.propertyListings.filter { (propertyItem:test) -> Bool in
            if propertyItem.title.lowercased().contains(self.searchController.searchBar.text!.lowercased())
            {
                return true
            }
            else
            {
                return false
            }
        }
        
        // Update the results TableView
        self.resultsController.tableView.reloadData()
    }
    
//    func updateSearchResults(for searchController: UISearchController) {
//        
//        // Filter through the table
//        
//        self.filteredPropertyListings = self.propertyListings.filter { (propertyItem:String) -> Bool in
//            if propertyItem.lowercased().contains(self.searchController.searchBar.text!.lowercased())
//            {
//                return true
//            }
//            else
//            {
//                return false
//            }
//        }
//        
//        // Update the results TableView
//        self.resultsController.tableView.reloadData()
//    }
    
    func queryDetailedSearch(criteria : String)
        {
            let scriptUrl = ProjectConfigs.hostAddress + ProjectConfigs.getPropertyListingsWithParams + criteria;
            
            let myUrl = URL(string: scriptUrl)
            var request = URLRequest(url: myUrl! as URL)
            request.httpMethod = "GET"
            
            print(scriptUrl)
            
            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
                if error != nil
                {
                    print("error=\(error)")
                    return
                }
                print("call to server successful")
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as? Array<Any>
                    
                    if let parseJSON = json {
                        
                        
                        var propertyListingObj : PropertyListing! = PropertyListing()
                        var count = 11
                        
                        for item in parseJSON as! [[String:Any]]
                        {
                            propertyListingObj = PropertyListing()
                            let title = item["TITLE"]! as! String
                            let address = item["ADDRESS"]! as! String
                            let zipcode = item["ZIP_CODE"]! as! String
                            let rent = item["PRICE"]! as! String
                            let roomates = item["NUMBER_OCCUPANTS"]! as! String
                            let animals = item["IS_PET_ALLOWED"]! as! String
                            
                            var item : test;
                            
                            if(count > 1)
                            {
                                //self.propertyImages.append("apartments\(count)")
                                //item.image = UIImage.init(named: "apartments\(count)")!
                                item = test(title: title, image: UIImage.init(named: "apartments\(count)")!)
                                count -= 1;
                            }
                            else
                            {
                                //self.propertyImages.append("apartments\(count)")
                                //item.image = UIImage.init(named: "apartments\(count)")!
                                item = test(title: title, image: UIImage.init(named: "apartments\(count)")!)
                                count = 11;
                            }
                            
                            self.propertyListings.append(item)
                            
                            propertyListingObj.propertyTitle = title
                            propertyListingObj.propertyAddress = address
                            propertyListingObj.propertyZipCode = zipcode
                            propertyListingObj.propertyRent = rent
                            propertyListingObj.propertyRoomates = roomates
                            propertyListingObj.propertyAnimals = animals
                            
                            self.propertyDesc.append(propertyListingObj)
                        }
                        
                        
                        
                        DispatchQueue.main.async {
                            self.myTableView.reloadData()
                        }
                    }
                    else
                    {
                        print ("hier");
                    }
                } catch {
                    print("Error:::: ",error.localizedDescription)
                }
                
                
            })
            
            task.resume();
        }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableView
        {
            return self.propertyListings.count
        }
        else
        {
            return self.filteredPropertyListings.count
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        if tableView == self.tableView
        {
            cell.textLabel?.text = self.propertyListings[indexPath.row].title
            //cell.imageView?.image = imageWithImage(image: self.propertyListings[indexPath.row].image)
            cell.imageView?.image = self.propertyListings[indexPath.row].image
            //cell.imageView?.frame = CGRect(x: 20, y: 20, width: 200, height: 200)
        }
        else
        {
            cell.textLabel?.text = self.filteredPropertyListings[indexPath.row].title
            cell.imageView?.image = self.filteredPropertyListings[indexPath.row].image
            
        }
        
        return cell
    }
    
    func imageWithImage(image:UIImage)->UIImage{
        
        UIGraphicsBeginImageContext( CGSize(width: 200, height: 200) )
        image.draw(in: CGRect(x: 0,y: 0,width: 200,height: 200))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!.withRenderingMode(.alwaysTemplate)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100;
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(tableView == self.tableView)
        {
            let listingDetailsVC = storyboard?.instantiateViewController(withIdentifier: "ListingDetailsViewController") as! ListingDetailsViewController
            //let value = propertyListings[indexPath.row]
            
            listingDetailsVC.selectedTitle = propertyListings[indexPath.row].title
            listingDetailsVC.selectedImage = propertyListings[indexPath.row].image
            listingDetailsVC.propertyListingObj = propertyDesc[indexPath.row]
            
            self.navigationController?.pushViewController(listingDetailsVC, animated: true)
        }
        else
        {
            
            let listingDetailsVC = storyboard?.instantiateViewController(withIdentifier: "ListingDetailsViewController") as! ListingDetailsViewController
            //let value = propertyListings[indexPath.row]
            
            listingDetailsVC.selectedTitle = filteredPropertyListings[indexPath.row].title
            listingDetailsVC.selectedImage = filteredPropertyListings[indexPath.row].image
            listingDetailsVC.propertyListingObj = propertyDesc[indexPath.row]
            
            self.navigationController?.pushViewController(listingDetailsVC, animated: true)
        }
        
        
    }
}
