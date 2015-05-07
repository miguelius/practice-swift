//
//  ViewController.swift
//  Editing Photos
//
//  Created by Domenico Solazzo on 07/05/15.
//  License MIT
//

import UIKit
import Photos
import OpenGLES

class ViewController: UIViewController {

    /* These two values are our way of telling the Photos framework about
    the identifier of the changes that we are going to make to the photo */
    let editFormatIdentifier = NSBundle.mainBundle().bundleIdentifier;
    /* Just an application-specific editing version */
    let editFormatVersion = "0.1"
    /* This is our filter name. We will use this for our Core Image filter */
    let filterName = "CIColorPosterize"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

