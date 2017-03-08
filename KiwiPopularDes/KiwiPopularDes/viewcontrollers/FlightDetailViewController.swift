//
//  FlightDetailViewController.swift
//  KiwiPopularDes
//
//  Created by Hung Nguyen on 3/8/17.
//  Copyright © 2017 Hung Nguyen. All rights reserved.
//

import Foundation
import UIKit

class FlightDetailViewController: UIViewController{
    
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
    
    var flight: Flight?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(flight?.cityTo)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
