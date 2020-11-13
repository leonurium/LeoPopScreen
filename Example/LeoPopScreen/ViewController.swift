//
//  ViewController.swift
//  LeoPopScreen
//
//  Created by ranggaleoo on 11/10/2020.
//  Copyright (c) 2020 ranggaleoo. All rights reserved.
//

import UIKit
import LeoPopScreen

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func show(_ sender: UIButton) {
        let popScreen = LeoPopScreen(on: self, delegate: self, dataSource: self)
//        popScreen.delegate = self
//        popScreen.dataSource = self
//        popScreen.show(on: self)
    }
}

extension ViewController: LeoPopScreenDelegate {
    func didTapPrimaryButton(view: LeoPopScreen) {
        
    }
    
    func didTapSecondaryButton(view: LeoPopScreen) {
        
    }
}

extension ViewController: LeoPopScreenDataSource {
    var image: UIImage? {
        return UIImage(named: "")
    }
    
    var titleText: String {
        return "Title Text"
    }
    
    var bodyText: String {
        return "Body Text"
    }
    
    var buttonPrimaryText: String {
        return "Button Primary Text"
    }
    
    var buttonSecondaryText: String {
        return "Button Secondary Text"
    }
    
    var presentationStyle: UIModalPresentationStyle {
        return .fullScreen
    }
}

