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
    
    var textField : UITextField! {
        didSet {
            textField.center = view.center
            textField.textAlignment = .center
            textField.layer.borderColor = UIColor.orange.cgColor
            textField.layer.borderWidth = 2.0
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Note: you don't have to set a proper origin for the CountryPicker
        // if you're going to use it as an inputView. It will be positioned at the
        // bottom of the screen by default.
        let countryPicker = CountryPicker(frame: CGRect(x: 0,y: 0,width: self.view.frame.size.width, height: 216))
        countryPicker.countryDelegate = self
        
        
        
        textField = UITextField(frame: CGRect(x: 0,y: 0,width: 40,height: 30))
        textField.inputView = countryPicker
        view.addSubview(textField)
        
        // Show the country code from NSlocale by default
        textField.text = countryPicker.pickedCountry?.iso
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController : CountryPickerDelegate {
    func countryPicker(_ picker: CountryPicker, didSelectCountry country: Country) {
        textField.text = country.iso
    }

}
