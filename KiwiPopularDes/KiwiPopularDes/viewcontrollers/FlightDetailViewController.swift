//
//  FlightDetailViewController.swift
//  KiwiPopularDes
//
//  Created by Hung Nguyen on 3/8/17.
//  Copyright © 2017 Hung Nguyen. All rights reserved.
//

import Foundation
import UIKit
import Alamofire


class FlightConnectionCell: UITableViewCell {
    @IBOutlet weak var lFrom: UILabel!
    @IBOutlet weak var lTo: UILabel!
    @IBOutlet weak var lFromCode: UILabel!
    @IBOutlet weak var lToCode: UILabel!
    @IBOutlet weak var lDateDe: UILabel!
    @IBOutlet weak var lDateArrival: UILabel!
    @IBOutlet weak var lTimeDe: UILabel!
    @IBOutlet weak var lTimeArr: UILabel!
}

class FlightDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var imgCityTo: UIImageView!
    @IBOutlet weak var labelTitleCityTo: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelCurrency: UILabel!
    @IBOutlet weak var labelTitleCityFrom: UILabel!
    @IBOutlet weak var labelDetailCityFrom: UILabel!
    @IBOutlet weak var labelDetailCityTo: UILabel!
    @IBOutlet weak var labelDetailCityFromCode: UILabel!
    @IBOutlet weak var labelDetailCityToCode: UILabel!
    @IBOutlet weak var labelDetailDateDeparture: UILabel!
    @IBOutlet weak var labelDetailDateArrival: UILabel!
    @IBOutlet weak var labelDetailTimeDeparture: UILabel!
    @IBOutlet weak var labelDetailTimeArrival: UILabel!
    @IBOutlet weak var labelDetailDuration: UILabel!
    
    @IBOutlet weak var labelConnectionTitle: UILabel!
    @IBOutlet weak var tableViewConection: UITableView!
    
    
    var flight: Flight!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageUrl = "https://images.kiwi.com/photos/600/\(flight.cityToId).jpg"
        Alamofire.request(imageUrl, method: .get).response { response in
            if let data = response.data{
                self.imgCityTo.image = UIImage(data: data)
            }
        }
        
        self.labelTitleCityTo.text = "Visit " + flight.cityTo
        self.labelPrice.text = String(describing: flight.price)
        self.labelCurrency.text = flight.currency
        self.labelTitleCityFrom.text = "From: " + (flight.cityFrom)
        self.labelDetailCityFrom.text = flight.cityFrom
        self.labelDetailCityTo.text = flight.cityTo
        self.labelTitleCityTo.text = flight.cityTo
        self.labelDetailCityFromCode.text = flight.flyFrom
        self.labelDetailCityToCode.text = flight.flyTo
        self.labelDetailDateDeparture.text = Helper.getDayOfWeek(flight.timeDeparture) + ", " + Helper.getDate(flight.timeDeparture)
        self.labelDetailDateArrival.text = Helper.getDayOfWeek(flight.timeArrival) + ", " + Helper.getDate(flight.timeArrival)
        self.labelDetailTimeDeparture.text = Helper.getTime(flight.timeDeparture)
        self.labelDetailTimeArrival.text = Helper.getTime(flight.timeArrival)
        
        if flight.route.count == 1{
            self.labelDetailDuration.text = "Direct flight - Duration: " + flight.duration
            self.labelConnectionTitle.isHidden = true
            self.tableViewConection.isHidden = true
        }
        else{
            self.labelDetailDuration.text = String(flight.route.count-1) + " stops - Duration: " + flight.duration
        }
        
        tableViewConection.preservesSuperviewLayoutMargins = false
        tableViewConection.separatorInset = UIEdgeInsets.zero
        tableViewConection.layoutMargins = UIEdgeInsets.zero
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if flight.route.count == 1{
            return 0
        }
        return flight.route.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FlightConnectionCell", for: indexPath) as? FlightConnectionCell
        
        let aFlight = flight.route[indexPath.row]
        cell?.lFrom.text = aFlight.cityFrom
        cell?.lTo.text = aFlight.cityTo
        cell?.lFromCode.text = aFlight.flyFrom
        cell?.lToCode.text = aFlight.flyTo
        cell?.lDateDe.text = Helper.getDayOfWeek(aFlight.timeDeparture) + ", " + Helper.getDate(aFlight.timeDeparture)
        cell?.lDateArrival.text = Helper.getDayOfWeek(aFlight.timeArrival) + ", " + Helper.getDate(aFlight.timeArrival)
        cell?.lTimeDe.text = Helper.getTime(aFlight.timeDeparture)
        cell?.lTimeArr.text = Helper.getTime(aFlight.timeArrival)
        
        
        return cell!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
