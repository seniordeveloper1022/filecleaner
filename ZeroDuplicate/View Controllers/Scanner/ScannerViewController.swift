//
//  ScannerViewController.swift
//  ZeroDuplicate
//
//  Created by Ghafar Tanveer on 25/03/2019.
//  Copyright © 2019 trivalent. All rights reserved.
//

import UIKit
import MBCircularProgressBar
import Photos
import GoogleMobileAds

class ScannerViewController: BaseViewController,TopBarDelegate {

    @IBOutlet weak var viewScannerBackground:UIView!
    @IBOutlet weak var viewProgessBar:MBCircularProgressBarView!
    @IBOutlet weak var lblRemainingTime:UILabel!
    @IBOutlet weak var viewScanningInfo:UIView!
    @IBOutlet weak var lblScanTime:UILabel!
    @IBOutlet weak var lblNumberOfPhotos:UILabel!
    @IBOutlet weak var lblTotalFound:UILabel!
    @IBOutlet weak var lblScanning:UILabel!
    @IBOutlet weak var lblMatchesFound : UILabel!
    @IBOutlet weak var btnScan:UIButton!
    @IBOutlet weak var BtnFix : UIButton!

 var interstitial: GADInterstitial!
    
    
    var allPhotos : PHFetchResult<PHAsset>? = nil
    var isFromMenu:Bool? = false
    var isExact : Bool? = false
    var imagesList:[ImageViewModel] = [ImageViewModel]()
    var searchResults:[Int:[ImageViewModel]] = Global.shared.searchResults
    var adInterstital : GADInterstitial?
    
    var similarityThershold:Int = 50
    var isScanningStop:Bool? = false
    var timer:Timer?
    var counter:Int = 0
    var timeValue = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewProgessBar.textOffset = CGPoint(x: 0, y: -10)
       // self.btnScan.setTitle("Stop Scan", for: .normal)
        self.viewScannerBackground.layer.cornerRadius = 125
        self.setBorderColor(view: self.viewScannerBackground, color: DARK_BLUE_COLOR, width:55)
        self.viewProgessBar.valueFontName = "HelveticaNeue-Medium"
        self.viewProgessBar.unitFontName = "HelveticaNeue-Bold"
        self.viewProgessBar.valueFontSize = 48
        self.viewProgessBar.unitFontSize = 48
        self.viewScanningInfo.isHidden = false
        self.lblScanning.text = "SCANNING"
        self.allPhotos = Global.shared.allPhotos
        self.lblScanTime.text = "Time Elapsed: 0:00:00"
        self.lblScanning.isHidden = false
        
       
        PHPhotoLibrary.requestAuthorization { (status) in
            switch status {
            case .authorized:
                print("Good to proceed")
                let fetchOptions = PHFetchOptions()
                self.allPhotos = PHAsset.fetchAssets(with: .image, options: fetchOptions)
                Global.shared.allPhotos = self.allPhotos
                self.setViews()
                self.getAllImages(listImages: self.allPhotos!)
            case .denied, .restricted:
                print("Not allowed")
            case .notDetermined:
                print("Not determined yet")
            }
        }
        GADRewardBasedVideoAd.sharedInstance().delegate = self
        GADRewardBasedVideoAd.sharedInstance().load(GADRequest(),
                                                    withAdUnitID: "ca-app-pub-3940256099942544/5224354917")
        //interstitial = createAndLoadInterstitial()
    }
//    func createAndLoadInterstitial()  {
//        self.interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
//
//
//        self.interstitial.delegate = self
//        let adRequest = GADRequest()
//        adRequest.testDevices = [ kGADSimulatorID, "c068f97934068fe64eb7120944cca8b8c9990999" ]
//        self.interstitial.load(adRequest)
//        if interstitial.isReady {
//            interstitial.present(fromRootViewController: self)
//        }
//    }
//    private func createAndLoadInterstitial() -> GADInterstitial? {
//        interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
//                //Add_Unit_ID
//
////        guard let interstitial = interstitial else {
////            return nil
////        }
////
//        let request = GADRequest()
//        // Remove the following line before you upload the app
//        request.testDevices = [ kGADSimulatorID, UIDevice.current.identifierForVendor!.uuidString]
//        interstitial.load(request)
//        interstitial.delegate = self
//
//        return interstitial
//    }
//    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
//        self.interstitial = ad
//    }
    
    func createAndLoadInterstitial() -> GADInterstitial {
        
       
        let interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/5224354917")
        interstitial.delegate = self
        interstitial.load(GADRequest())
        return interstitial
    }
    
//    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
//        interstitial = createAndLoadInterstitial()
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        if interstitial.isReady {
//            interstitial.present(fromRootViewController: self)
//        } else {
//            print("Ad wasn't ready")
//        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let container = self.mainContainer{
            container.lblTitle.text = "PHOTO SCAN"
            container.delegate = self
            container.btnEdit.isHidden = true
            container.changeButtonColor(tag: 0)
            if(!self.isFromMenu!){
                container.addBackIcon(isAddBack: true)
            }
        }
    }
    func setViews()  {
        GCD.async(.Main) {
            self.viewScanningInfo.isHidden = false
            self.lblNumberOfPhotos.text = "Scanning Photos: \(self.allPhotos!.count)"
            self.lblRemainingTime.text = "Time Remainig: 0:00:00"
        }
        
    }
    
    func getAllImages(listImages:PHFetchResult<PHAsset>)  {
       
        
        self.imagesList = [ImageViewModel]()
        for i in 0..<listImages.count{
            let asset = listImages[i]
            let imageVM = ImageViewModel(asset: asset)
            self.imagesList.append(imageVM)
        }
        GCD.async(.Main) {
            
            self.actionStartScanning(self.btnScan)
        }

    }

    func scanDuplicateImages() {
        
        if(self.imagesList.count > 0){
            
            for i in 0 ... self.imagesList.count - 1{
                if(self.isScanningStop!){
                    break
                }
                
                var waveletMatrix = [[Double]](repeating: [Double](repeating: 0, count: 128), count: 128)
                
                let imageVm = self.imagesList[i]
                


                let semaphore = DispatchSemaphore(value: 0)
               // print("TIME 1 \(Utilities.getStringFromDate())")
                imageVm.asset.getURL { (url) in

                    imageVm.path = url!.absoluteString
                    imageVm.image = UIImage(contentsOfFile: url!.path)!
                    let urlTokens = imageVm.path.components(separatedBy: "/")
                    imageVm.cameraName = urlTokens[urlTokens.count - 1]
                    semaphore.signal()
                }
                semaphore.wait()
              // print("TIME 2 \(Utilities.getStringFromDate())")
                
                ImageProcessing.getMatricesForImageData(image: imageVm.image, waveletCoeff: &waveletMatrix, positiveCoeff: &self.imagesList[i].positiveCoeff, negativeCoeff: &self.imagesList[i].negativeCoeff)
                
                var foundMatch = false
                if(i > 0){
                    for j in (0 ... i-1).reversed(){
                        
                        if(self.isScanningStop!){
                            break
                        }
                        
                        let prevImage = self.imagesList[j]
                        if(!prevImage.isDeleted){
                            let similarity:Double = ImageProcessing.getSimilarity(waveletMatrix, prevImage.positiveCoeff, prevImage.negativeCoeff)
                            if(Int(similarity) >= self.similarityThershold){
                                imageVm.similarity = similarity
                                if(prevImage.similarTo.isEmpty){
                                    imageVm.setSimilarTo(similarTo: prevImage.path)
                                }else{
                                    imageVm.setSimilarTo(similarTo: prevImage.similarTo)
                                }
                                self.addToResults(image: imageVm, scannedWith: prevImage)
                                foundMatch = true
                                break
                            }
                        }
                        
                    }
                    
                    if(foundMatch){
                        imageVm.positiveCoeff = [TWaveletPoint](repeating: TWaveletPoint(), count: 200)
                        imageVm.negativeCoeff = [TWaveletPoint](repeating: TWaveletPoint(), count: 200)
                        imageVm.isDeleted = true
                        
                }
               
                    GCD.async(.Main) {
                        let eachImageValue =  (i * 100) / self.imagesList.count
                        
                        var value = eachImageValue//eachImageValue * i
                        if(i == self.imagesList.count - 1){
                            value = 100
                        }
                        self.updateProgress(value: value)
                    }
                }
                
                
            }
            
           
        }
    
    }
    
    func updateProgress(value: Int)  {
       
        
        UIView.animate(withDuration: 1, animations: {
            self.viewProgessBar.value = CGFloat(value)
        }, completion: { (completed) in
            if(completed && value == 100){
                
                self.lblScanning.text = "SCAN COMPLETE"
                var totalDuplicateFound = 0
                for key in  self.searchResults.keys{
                    let images = self.searchResults[key]!
                    totalDuplicateFound = totalDuplicateFound + images.count - 1
                }
                self.lblTotalFound.text = "\(totalDuplicateFound)"
//                if(totalDuplicateFound == 0){
//                    self.BtnFix.isHidden = true
//                }else{
//                    self.BtnFix.isHidden = false
//                }
               
                self.viewScanningInfo.isHidden = true
                self.btnScan.setTitle("RESCAN", for: .normal)
                self.stopTimer()
//                self.interstitial = self.createAndLoadInterstitial()

            }
        })
    }
    
    func addToResults(image:ImageViewModel, scannedWith: ImageViewModel ) {
        var results = [ImageViewModel]()
        let key = image.similarTo.hashValue
        results = self.searchResults[key] ?? [ImageViewModel]()
        
        if(results.count == 0){
            scannedWith.setSimilarTo(similarTo: scannedWith.path)
            results.append(scannedWith)
        }
        results.append(image)
        self.searchResults[key] = results
        Global.shared.searchResults = self.searchResults
        
    }
    func actionCallBackMoveBack() {
        if(self.isFromMenu!){
            
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    func initializeTimer()  {
        GCD.async(.Main) {
            self.viewScanningInfo.isHidden = false
            self.lblScanTime.text = "Time Elapsed: 0:00:00"
            self.lblRemainingTime.text = "Total Scan Time: 0:00:00"
            self.counter = 0
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimeValue), userInfo: nil, repeats: true)
        }
       
    }
    @objc func updateTimeValue()  {
        self.counter = self.counter  + 1
        
        let minuts = self.counter / 60
        let hours = minuts / 60
        let seconds = self.counter % 60
        self.timeValue = ""
        if(hours > 0){
            timeValue = "\(hours):"
        }else{
            timeValue = "0:"
        }
        if(minuts > 0){
            if(minuts > 9){
                timeValue = timeValue + "\(minuts):"
            }else{
                timeValue = timeValue + "0\(minuts):"
            }
        }else{
             timeValue = timeValue + "00:"
        }
        if(seconds > 0){
            if(seconds > 9){
                timeValue = timeValue + "\(seconds)"
            }else{
                timeValue = timeValue + "0\(seconds)"
            }
        }else{
            timeValue = timeValue + "00"
        }
        
        self.lblScanTime.text = "Time Elapsed: \(timeValue)"
    }
    func stopTimer()  {
        self.counter = 0
        self.timer?.invalidate()
        self.lblRemainingTime.text = "Total Scan Time: \(self.timeValue)"
    }
    
    
    @IBAction func actionStartScanning(_ sender:UIButton){
        
            let title = sender.titleLabel?.text
        
        if(title?.lowercased() == "start scan"){
            if(self.imagesList.count > 0){
                sender.setTitle("STOP SCAN", for: .normal)
                self.lblScanning.isHidden = false
                self.lblScanning.text = "SCANNING"
                let thread = Thread {
                    self.initializeTimer()
                }
                thread.start()
                
               
                
                GCD.async(.Background) {
                    self.scanDuplicateImages()
                }
            }
        }else if(title?.lowercased() == "stop scan"){
            self.isScanningStop = true
            self.lblScanning.isHidden = false
            self.lblScanning.text = "SCAN COMPLETE"
            //sender.setTitle("RESCAN", for: .normal)
            self.stopTimer()
            GCD.async(.Main, delay: 1) {
                self.updateProgress(value: 100)
                self.isScanningStop = false
            }
        }else{
            
            if(self.imagesList.count > 0){
                self.viewProgessBar.value = 0
                self.searchResults = [Int:[ImageViewModel]]()
                sender.titleLabel?.text = "STOP SCAN"
                self.btnScan.setTitle("STOP SCAN", for: .normal)
                self.lblScanning.isHidden = false
                self.lblScanning.text = "SCANNING"
                self.initializeTimer()
                GCD.async(.Background) {
                    self.scanDuplicateImages()
                }
            }

        }
    }
    
    
    @IBAction func actionFixImages(_ sender:UIButton){
        let storyboard = UIStoryboard(name: StoryboardName.Main, bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: ControllerIdentifier.ResultGroupsViewController) as? ResultGroupsViewController{
            vc.allPhotos = self.allPhotos
            vc.searchResults = self.searchResults
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

  
}
extension ScannerViewController: ResultGroupsControllerDelegate{
    func actionCallBackUpdateList() {
        self.searchResults = Global.shared.searchResults
    }
}
extension ScannerViewController: GADRewardBasedVideoAdDelegate{
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd,
                            didRewardUserWith reward: GADAdReward) {
        print("Reward received with currency: \(reward.type), amount \(reward.amount).")
        
        
    }
    
    func rewardBasedVideoAdDidReceive(_ rewardBasedVideoAd:GADRewardBasedVideoAd) {
        print("Reward based video ad is received.")
        if GADRewardBasedVideoAd.sharedInstance().isReady == true {
            GADRewardBasedVideoAd.sharedInstance().present(fromRootViewController: self)
        }
    }
    
    func rewardBasedVideoAdDidOpen(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Opened reward based video ad.")
    }
    
    func rewardBasedVideoAdDidStartPlaying(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad started playing.")
    }
    
    func rewardBasedVideoAdDidCompletePlaying(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad has completed.")
    }
    
    func rewardBasedVideoAdDidClose(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad is closed.")
//        GADRewardBasedVideoAd.sharedInstance().load(GADRequest(),
//                                                    withAdUnitID: "ca-app-pub-3940256099942544/1712485313")
    }
    
    func rewardBasedVideoAdWillLeaveApplication(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad will leave application.")
    }
    
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd,
                            didFailToLoadWithError error: Error) {
        print("Reward based video ad failed to load.")
        GADRewardBasedVideoAd.sharedInstance().load(GADRequest(),
                                                    withAdUnitID: "ca-app-pub-3940256099942544/5224354917")
    }
}
extension ScannerViewController: GADInterstitialDelegate {
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        print("Interstitial loaded successfully")
        ad.present(fromRootViewController: self)
    }

    func interstitialDidFail(toPresentScreen ad: GADInterstitial) {
        print("Fail to receive interstitial")
    }
    
//    /// Tells the delegate an ad request succeeded.
//    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
//        print("interstitialDidReceiveAd")
//    }
//
    /// Tells the delegate an ad request failed.
    func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
        print("interstitial:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    /// Tells the delegate that an interstitial will be presented.
    func interstitialWillPresentScreen(_ ad: GADInterstitial) {
        print("interstitialWillPresentScreen")
    }
    
    /// Tells the delegate the interstitial is to be animated off the screen.
    func interstitialWillDismissScreen(_ ad: GADInterstitial) {
        print("interstitialWillDismissScreen")
    }
    
    /// Tells the delegate the interstitial had been animated off the screen.
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        print("interstitialDidDismissScreen")
    }
    
    /// Tells the delegate that a user click will open another app
    /// (such as the App Store), backgrounding the current app.
    func interstitialWillLeaveApplication(_ ad: GADInterstitial) {
        print("interstitialWillLeaveApplication")
    }
}
