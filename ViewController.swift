//
//  ViewController.swift
//  SprayARound
//
//  Created by Rohan Kumar on 9/14/18.
//  Copyright © 2018 Rohan Kumar. All rights reserved.
//

import UIKit
import ARKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet weak var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let databaseRef = Database.database().reference()
        print("made it")
        databaseRef.child("data").queryOrderedByKey().observeSingleEvent(of: .value) { (snapshot) in
            let name = snapshot.value as? [String : AnyObject]
            
            print(name)
        }
        for i in 2...20 {
            let post:[String:AnyObject] = ["X":i as AnyObject, "Y":i as AnyObject, "Z":i as AnyObject, "img": "64string \(i)" as AnyObject ]
            
            databaseRef.child("data").childByAutoId().setValue(post)
        }
        
        
        databaseRef.child("data").queryOrderedByKey().observeSingleEvent(of: .value) { (snapshot) in
            let name = snapshot.value as? [String : AnyObject]
            
            print(name)
        }
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    
}

