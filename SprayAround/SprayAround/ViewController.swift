//
//  ViewController.swift
//  SprayAround
//
//  Created by AK on 9/14/18.
//  Copyright © 2018 AK. All rights reserved.
//

import UIKit
import ARKit
import MapKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
import CoreMotion
import CoreLocation

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var imageView: UIImageView!
    var locationManager = CLLocationManager()
    
    static var marker:Int = 0
    
    @IBAction func butt(_ sender: Any) {
        let image = UIImagePickerController()
        
        image.delegate = self
        
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        image.allowsEditing = false
        
        self.present(image, animated: true)
    }
    
    @IBOutlet weak var ARView: ARSCNView!
    
    var database:DatabaseReference
    override func viewDidLoad() {
        
        
        
        database = Database.database().reference()
        
        database.child("data").queryOrderedByKey().observeSingleEvent(of: .value) { (snapshot) in
            let name = snapshot.value as? [String : AnyObject]
            
            print(name)
        }

        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self as? CLLocationManagerDelegate
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
    
    @IBAction func imageAR(_ sender: Any) {
        var image = UIImage(named: "image")
         image = ARView.snapshot()
        let imageData:NSData = UIImagePNGRepresentation(image!)! as NSData
        let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
        
        //let dataRef = Database.database().reference()
        
        let post = ["picture": strBase64 as AnyObject]
        
        database.child("data").childByAutoId().setValue(post)
    }
    
    func decodeImage() -> UIImage {
        
        return UIImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        ARView.session.run(configuration)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        ARView.session.pause()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            imageView.image = image
        }
        else
        {
            //Error message
        }
        
        self.dismiss(animated: true, completion: nil)
    }
}

