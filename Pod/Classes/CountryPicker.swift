// Made by Samuel Beek (github.com/samuelbeek)
import SwiftyJSON //      TODO: make sure you don't require SwiftyJSON


/**
    Country object
    contains a name, iso country code and emoji, all strings.
*/
public struct Country {
    
    /// Name of the country
    public let name : String!
    
    /// ISO country code of the country
    public let iso : String!
    
    /// Emoji flag of the country
    public let emoji: String!
    
}


public protocol CountryPickerDelegate : UIPickerViewDelegate {
    
    /**
     Called by the CountryPicker when the user selects a country
     
     - parameter picker:  An object representing the CounrtyPicker requesting the data.
     - parameter country: The Selected Country
     */
    func countryPicker(picker: CountryPicker, didSelectCountry country: Country)
}

/** 
 The CountryPicker class uses a custom subclass of UIPickerView to display country names and flags (emoji flags in a slot machine interface. The user can choose a pick a country.
*/
public class CountryPicker : UIPickerView {
  
    /// The current picked Country
    public var pickedCountry : Country?
    
    /// The delegate for the CountryPicker
    public var countryDelegate : CountryPickerDelegate?
    
    /// The Content of the CountryPicker
    private var countryData = [Country]()
    
  
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.dataSource = self
        self.delegate = self
        loadData()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     Loads content from .json file
     */
    private func loadData() {
        let bundlePath = NSBundle(forClass: CountryPicker.self).pathForResource("SwiftCountryPicker", ofType: "bundle")
        
        if let path = NSBundle(path: bundlePath!)!.pathForResource("EmojiCountryCodes", ofType: "json")
        {
            
            do {
                let jsonData = try NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe)
                let jsonDict = try  NSJSONSerialization.JSONObjectWithData(jsonData, options: .AllowFragments)
                let json = JSON(jsonDict)
                var countryCode: String?
 
                if let local = NSLocale.currentLocale().objectForKey(NSLocaleCountryCode) as? String {
                    countryCode = local
                }
                
                
                for (_,subJson):(String, JSON) in json {
                    let country = Country(name: subJson["name"].stringValue, iso: subJson["code"].stringValue, emoji: subJson["emoji"].stringValue)
                    
                    // set current country if it's the local countr y
                    if country.iso == countryCode {
                        pickedCountry = country
                    }
                    
                    // append country
                    countryData.append(country)
                }
                
                countryData.sortInPlace { $1.name > $0.name }
                self.reloadAllComponents()
                
            } catch {
                print("error reading file")
                
            }
        }

    }
}

extension CountryPicker : UIPickerViewDataSource {
    
    public func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(countryData[row].emoji) - \(countryData[row].name)"
    }
    
    public func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countryData.count
    }
    
    public func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }

}

extension CountryPicker : UIPickerViewDelegate {

    public func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickedCountry = countryData[row]
        if let countryDelegate = self.countryDelegate {
            countryDelegate.countryPicker(self, didSelectCountry: countryData[row])
        }
    }

}

