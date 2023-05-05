//
//  SheetViewController.swift
//  WeatherApp
//
//  Created by Yusuf Emirhan Arslan on 1.05.2023.
//

import UIKit

class SheetViewController: UIViewController {
    
    @IBOutlet weak var customView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var currentDetailsView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let detailViews = DetailsView(frame: customView.bounds)
        customView.addSubview(detailViews)
        currentDetailsView = detailViews
        
    }
    
    @IBAction func changeSegmented(_ sender: Any) {
        
        currentDetailsView?.removeFromSuperview()
        
        switch segmentedControl.selectedSegmentIndex {
            
        case 0:
            let detailsView2 = DetailsView(frame: customView.bounds)
            customView.addSubview(detailsView2)
            currentDetailsView = detailsView2
        case 1:
            let airPollutionView = AirPollutionView(frame: customView.bounds)
            customView.addSubview(airPollutionView)
            currentDetailsView = airPollutionView
        default:
            break
        }
    }
    
    
}
