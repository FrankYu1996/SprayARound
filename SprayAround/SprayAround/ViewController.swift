//
//  ViewController.swift
//  SprayAround
//
//  Created by AK on 9/14/18.
//  Copyright © 2018 AK. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var ARView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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

    //39.3277606665676 -76.6222489604963 stairs
    //  39.3277639296599 -76.6222464805751
    // 39.3276998357856 -76.6222115385558 career
    
    

}

