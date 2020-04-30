//
//  HomeViewController.swift
//  ZeroDuplicate
//
//  Created by Waqas Ahmad on 15/03/2019.
//  Copyright © 2019 trivalent. All rights reserved.
//

import UIKit
import Photos

class HomeViewController: BaseViewController{

    @IBOutlet weak var btnSimilar : UIButton!
    @IBOutlet weak var btnExact : UIButton!
    
    var allPhotos : PHFetchResult<PHAsset>? = nil
    var imagesList:[ImageViewModel] = [ImageViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
//        GCD.async(.Background) {
//            PHPhotoLibrary.requestAuthorization { (status) in
//                switch status {
//                case .authorized:
//                    print("Good to proceed")
//                    let fetchOptions = PHFetchOptions()
//                    self.allPhotos = PHAsset.fetchAssets(with: .image, options: fetchOptions)
//                    self.getAllImages(scanType: 0, listImages: self.allPhotos!)
//                case .denied, .restricted:
//                    print("Not allowed")
//                case .notDetermined:
//                    print("Not determined yet")
//                }
//            }
//        }
        
        
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
         print("Time before execution \(Utilities.getStringFromDate())")
        var pixels:[Int8] = [Int8](repeating: 0, count: 16384)
        var arr: [Int8] = [Int8](repeating:0, count:9)
        let w = 128
        let semaphore = DispatchSemaphore(value: 0)
        for j in (1...128 - 2).reversed() {
            
            let thread = Thread {
                self.startPocessing(arrPixels: pixels, j: j, array: arr)
                if(j == 1){
                    semaphore.signal()
                }
            }
            thread.start()

        }
        semaphore.wait()
        print("Time after execution \(Utilities.getStringFromDate())")
    }
    func startPocessing(arrPixels:[Int8],j:Int, array:[Int8])  {
        var arr = array
        var pixels = arrPixels
        let w = 128
        for i in (1...128 - 2).reversed() {
            arr[0] = pixels[(i-1) + ((j-1) * w)]
            arr[1] = pixels[i + ((j - 1) * w)]
            arr[2] = pixels[(i + 1) + ((j - 1) * w)]
            
            arr[3] = pixels[(i-1) + (j * w)]
            arr[4] = pixels[i + (j * w)]
            arr[5] = pixels[(i + 1) + (j * w)]
            
            
            arr[6] = pixels[(i-1) + ((j + 1) * w)]
            arr[7] = pixels[i + ((j + 1) * w)]
            arr[8] = pixels[(i + 1) + ((j + 1) * w)]
            
            arr.sort()
            pixels[i + (j * w)] = arr[4];
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let container = self.mainContainer{
            container.lblTitle.text = "Home"
            container.addBackIcon()
            container.btnEdit.isHidden = true
            container.changeButtonColor(tag: 0)
        }
    }
    func getAllImages(scanType:Int, listImages:PHFetchResult<PHAsset>)  {
        
        for i in 0..<listImages.count{
            let asset = listImages[i]
            let imageVM = ImageViewModel(asset: asset)
            self.imagesList.append(imageVM)
        }
        GCD.async(.Background) {
            for imageVM in self.imagesList{
                //let semaphore = DispatchSemaphore(value: 0)
                imageVM.asset.getURL { (url) in
                    imageVM.path = url!.absoluteString
                    imageVM.image = UIImage(contentsOfFile: url!.path)!
                    let urlTokens = imageVM.path.components(separatedBy: "/")
                    imageVM.cameraName = urlTokens[urlTokens.count - 1]
                  //  semaphore.signal()
                }
                //semaphore.wait()
                
            }
        }
        
        
    }
    
    
    @IBAction func actionSimilar(_ sender:Any){
        Global.shared.searchResults.removeAll()
        let storyboard = UIStoryboard(name: StoryboardName.Main, bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: ControllerIdentifier.ScannerViewController) as? ScannerViewController{
            
            vc.similarityThershold = Global.shared.similarityThershold
            vc.imagesList = self.imagesList
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
    }
    @IBAction func actionExact(_ sender:Any){
        Global.shared.searchResults.removeAll()
        let storyboard = UIStoryboard(name: StoryboardName.Main, bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: ControllerIdentifier.ScannerViewController) as? ScannerViewController{
            
            vc.similarityThershold = 100
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    
}
