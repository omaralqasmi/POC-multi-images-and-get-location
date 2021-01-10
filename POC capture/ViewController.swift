//
//  ViewController.swift
//  POC capture
//
//  Created by Omar AlQasmi on 1/10/21.
//

import UIKit
import BSImagePicker
import Photos
import LocationPickerViewController


class ViewController: UIViewController, LocationPickerDelegate {
    let imagePicker = ImagePickerController()

    @IBOutlet weak var imgImage: UIImageView!
    @IBOutlet weak var imagesCollection: UICollectionView!
    @IBOutlet weak var lblLocation: UILabel!
    var arrImages : [UIImage] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareImagePicker()
        // Do any additional setup after loading the view.
        
    }
    @IBAction func btnPickLocation(_ sender: Any) {

        preparLocationPicker()

    }
    @IBAction func btnActionCapture(_ sender: Any) {
        getPhotos()
    }
    
//    func storeLocation(locationItem: LocationItem) {
//        if let index = historyLocationList.index(of: locationItem) {
//            historyLocationList.remove(at: index)
//        }
//        historyLocationList.append(locationItem)
//    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }


}
//MARK: - IMAGES
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func prepareImagePicker() {
        imagePicker.settings.selection.max = 5
        imagePicker.settings.theme.selectionStyle = .numbered
        imagePicker.settings.fetch.assets.supportedMediaTypes = [.image, .video]
        imagePicker.settings.selection.unselectOnReachingMax = true
        imagesCollection.delegate = self
        imagesCollection.dataSource = self

    }
    func getPhotos() {
        presentImagePicker(imagePicker, select: { (asset) in
            // User selected an asset. Do something with it. Perhaps begin processing/upload?
        }, deselect: { (asset) in
            // User deselected an asset. Cancel whatever you did when asset was selected.
        }, cancel: { (assets) in
            // User canceled selection.
        }, finish: { (assets) in
            self.arrImages.removeAll()
            self.convertToImages(assets)
        })

    }

    func convertToImages(_ assets : [PHAsset]) {
        
        for asset in assets {
            let options = PHImageRequestOptions()
            options.isSynchronous = true

            // Request the maximum size. If you only need a smaller size make sure to request that instead.
            PHImageManager.default().requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFill, options: options) { (image, info) in
                // Do something with image
                self.arrImages.append(image!)
            }
            
        }
        self.imgImage.image = self.arrImages[0]
        self.imagesCollection.reloadData()


    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        arrImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imagesCollection.dequeueReusableCell(withReuseIdentifier: "image", for: indexPath) as! CollectionViewCell
        cell.imgImage.image = arrImages[indexPath.row]
        return cell
    }
    
    
}

//MARK: - LOCATION
extension ViewController  {
    func preparLocationPicker() {
        let customLocationPicker = CustomLocationPickerVC()
//        customLocationPicker.isAllowArbitraryLocation = arbitraryLocationSwitch.isOn
        customLocationPicker.viewController = self
        let navigationController = UINavigationController(rootViewController: customLocationPicker)
        present(navigationController, animated: true, completion: nil)
    }
    func locationDidSelect(locationItem: LocationItem) {
        print("Select delegate method: " + locationItem.name)
    }
    
    func locationDidPick(locationItem: LocationItem) {
        showLocation(locationItem: locationItem)
//        storeLocation(locationItem: locationItem)
    }
    func showLocation(locationItem: LocationItem) {
        lblLocation.text = locationItem.name
//        locationAddressTextField.text = locationItem.formattedAddressString
    }

}



