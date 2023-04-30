//
//  SheetViewController.swift
//  WeatherApp
//
//  Created by Yusuf Emirhan Arslan on 1.05.2023.
//

import UIKit

class SheetViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
    
    
    @IBAction func changeSegmented(_ sender: Any) {
        
        switch segmentedControl.selectedSegmentIndex {
            
        case 0:
            print("0.endeks seçildi")
            // view olacak view'in sınıfı değişecek
        case 1:
            print("1.endesk seçildi")
            // burada da viewin sınıfı değişecek
        default:
            break
        }
    }
    
}
