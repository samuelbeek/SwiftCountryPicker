// Made by Samuel Beek (github.com/samuelbeek)
import SwiftyJSON //      TODO: make sure you don't require SwiftyJSON

public struct Country {
    
    public let name : String!
    public let iso : String!
    public let emoji: String!
    
}

public protocol CountryPickerDelegate {
    func countryPicker(picker: CountryPicker, didSelectCountry country: Country)
}

public class CountryPicker : UIView, UIPickerViewDelegate {
    
    private var picker : UIPickerView!
    public var delegate : CountryPickerDelegate?
    private var countryData = [Country]()
    private var pickedCountry : Country?

    override public init(frame: CGRect) {
        super.init(frame: frame)
        picker = UIPickerView(frame: self.bounds)
        picker.delegate = self
        picker.dataSource = self;
        self.addSubview(picker)
        loadData()

    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let delegate = delegate {
            delegate.countryPicker(self, didSelectCountry: countryData[row])
        }
    }
    
    /**
     Loads content from .json file
     */
    func loadData() {
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
                picker.reloadAllComponents()
                
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
        print(countryData.count)
        return countryData.count
    }
    
    public func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }

}


