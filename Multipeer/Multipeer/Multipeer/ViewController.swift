//
//  ViewController.swift
//  Multipeer
//
//  Created by Domenico on 04/05/16.
//  Copyright © 2016 Domenico Solazzo. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var images = [UIImage]()
    
    var peerID: MCPeerID!
    var mcSession: MCSession!
    var mcAdvertiserAssistant: MCAdvertiserAssistant!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
