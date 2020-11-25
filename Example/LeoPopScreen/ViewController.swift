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
//        let popScreen = LeoPopScreen(configuration: .init(type: .forceUpdateApp), on: self, delegate: self)
        let popScreen = LeoPopScreen(configuration: .init(type: .batteryLevelWarning))
        popScreen.dataSource = self
        popScreen.delegate = self
        popScreen.show(on: self)
//        LeoPopScreen(on: self, delegate: self, dataSource: self)
//        let popScreen = LeoPopScreen()
//        popScreen.delegate = self
//        popScreen.dataSource = self
//        popScreen.show(on: self)
    }
}

extension ViewController: LeoPopScreenDelegate {
    func didCancel(view: LeoPopScreen) {
        print("Cancel")
    }
    
    func didTapPrimaryButton(view: LeoPopScreen) {
        view.dismiss(animated: true, completion: nil)
    }
    
    func didTapSecondaryButton(view: LeoPopScreen) {
        view.dismiss(animated: true, completion: nil)
    }
}

extension ViewController: LeoPopScreenDataSource {
    var buttonPrimaryText: String? {
        return nil
    }
    
    var buttonSecondaryText: String? {
        return nil
    }
    
    var image: UIImage? {
        return UIImage(named: "image_update")
    }
    
    var titleText: String? {
        return nil
    }
    
    var bodyText: String? {
        return nil
    }
    
    var presentationStyle: UIModalPresentationStyle {
        return .fullScreen
    }
}

