//
//  ViewController.swift
//  Mocky
//
//  Created by Przemysław Wośko on 05/19/2017.
//  Copyright (c) 2017 Przemysław Wośko. All rights reserved.
//

import UIKit
import CoreGraphics

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

protocol TestAutoImport: AutoMockable { }
