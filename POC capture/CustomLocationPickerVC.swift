//
//  CustomLocationPickerVC.swift
//  POC capture
//
//  Created by Omar AlQasmi on 1/10/21.
//

import UIKit
import LocationPickerViewController

class CustomLocationPickerVC: LocationPicker {
    
    var viewController: ViewController!

    override func viewDidLoad() {
        super.addBarButtons()
        super.setLocationDeniedAlertControllerTexts(title: "DEnied", message: "please grant", grantText: "grantt", cancelText: "cancel")
        super.viewDidLoad()
    }
    
    @objc override func locationDidSelect(locationItem: LocationItem) {
        print("Select overrided method: " + locationItem.name)
    }
    
    @objc override func locationDidPick(locationItem: LocationItem) {
        print(locationItem)
        viewController.showLocation(locationItem: locationItem)
//        viewController.storeLocation(locationItem: locationItem)
    }
}
