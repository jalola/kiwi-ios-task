//
//  ListDestinationViewController.swift
//  KiwiPopularDes
//
//  Created by Hung Nguyen on 3/7/17.
//  Copyright © 2017 Hung Nguyen. All rights reserved.
//

import Foundation
import UIKit
import Alamofire


class FlightCell: UITableViewCell {
    @IBOutlet weak var labelCityTo: UILabel!
    @IBOutlet weak var labelCountryTo: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelCurrency: UILabel!
}


class ListDestinationViewController : UITableViewController{
    
    var flights: [Flight] = []{
        didSet{
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let todayJsonFile = Helper.getDateForAPI(offset: 0, sep: "-") + "-json"
        let todayJson = Helper.readFile(todayJsonFile)
        
        if todayJson == "" {
            let today = Helper.getDateForAPI(offset: 0, sep: "/")
            let nextMonth = Helper.getDateForAPI(offset: 30, sep: "/")
            
            let urlString = "https://api.skypicker.com/flights?v=2&sort=popularity&asc=0&locale=en&daysInDestinationFrom=&daysInDestinationTo=&affilid=&children=0&infants=0&flyFrom=CZ&to=anywhere&featureName=aggregateResults&dateFrom=\(today)&dateTo=\(nextMonth)&typeFlight=oneway&one_per_date=0&oneforcity=1&wait_for_refresh=0&adults=1&limit=10"
            
            Alamofire.request(urlString).responseJSON { response in
                
                if let jsonDict = response.result.value as? [String:Any] {
                    self.getOffersForToday(jsonDict: jsonDict)
                }
            }
        }
        else{
            self.getOffersForToday(jsonDict: Helper.stringToJson(text: todayJson)!)
        }
    }
    
    func getOffersForToday(jsonDict: [String:Any]){
        
        let allFlights = Flight.parseFlight(jsonDict)
        var availableOffers = [Flight]()
        
        let yesterdayOfferFile = Helper.getDateForAPI(offset: -1, sep: "-") + "-offer"
        let yesterdayOffers = Helper.readFile(yesterdayOfferFile)
        
        print("yesterday offers: \(yesterdayOffers)")
        if yesterdayOffers != ""{
            let previousOffers = yesterdayOffers.components(separatedBy: ",")
            
            for aFlight in allFlights{
                var found = false
                for cityToId in previousOffers{
                    if cityToId == aFlight.cityToId{
                        found = true
                        break
                    }
                }
                if found == false{
                    availableOffers.append(aFlight)
                }
            }
        }
        else{
            availableOffers = allFlights
        }
        
        if availableOffers.count > 5{
            self.flights = Array(availableOffers.prefix(5))
        }
        else{
            self.flights = availableOffers
        }
        
        //save today offers
        let jsonString = Helper.jsonToString(json: jsonDict)
        //print(jsonString)
        
        let todayJsonFile = Helper.getDateForAPI(offset: 0, sep: "-") + "-json"
        Helper.writeFile(todayJsonFile, text: jsonString)
        
        var destinations = [String]()
        for aFlight in self.flights{
            destinations.append(aFlight.cityToId)
        }
        
        let todayOffers = destinations.joined(separator: ",")
        print("today offers: \(todayOffers)")
        
        let todayOfferFile = Helper.getDateForAPI(offset: 0, sep: "-") + "-offer"
        Helper.writeFile(todayOfferFile, text: todayOffers)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flights.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FlightCell", for: indexPath) as? FlightCell
        
        let aFlight = flights[indexPath.row]
        cell?.labelCityTo.text = aFlight.cityTo
        cell?.labelCountryTo.text = aFlight.countryTo
        cell?.labelPrice.text = String(aFlight.price)
        
        cell?.preservesSuperviewLayoutMargins = false
        cell?.separatorInset = UIEdgeInsets.zero
        cell?.layoutMargins = UIEdgeInsets.zero
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "showFlight",
            let des = segue.destination as? FlightDetailViewController,
            let flightIndex = tableView.indexPathForSelectedRow?.row {
            des.flight = flights[flightIndex]
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
