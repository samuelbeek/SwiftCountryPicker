//
//  ViewController.swift
//  SwiftCountryPicker
//
//  Created by Samuel Beek on 11/28/2015.
//  Copyright (c) 2015 Samuel Beek. All rights reserved.
//

import UIKit
import SwiftCountryPicker

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var textField = UITextField(frame: CGRectMake(0,0,200,50))
        textField.center = view.center
        view.addSubview(textField)
        
        var countryPicker = CountryPicker(frame: CGRectMake(0,self.view.frame.size.height-216,self.view.frame.size.width, 216))
        countryPicker.delegate = self
        textField.inputView = countryPicker
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController : CountryPickerDelegate {
    func countryPicker(picker: CountryPicker, didSelectCountry country: Country) {
        print(country.emoji)
    }

}