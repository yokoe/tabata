//
//  ViewController.swift
//  TabataDev
//
//  Created by Sota Yokoe on 2016/10/09.
//  Copyright © 2016年 Sota Yokoe. All rights reserved.
//

import Cocoa
import Tabata

class ViewController: NSViewController {
    @IBOutlet weak var imageView: NSImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        imageView.image = Tabata().scale(0.1).process(image: NSImage(named: "Kyoto")!)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

