// Made by Samuel Beek (github.com/samuelbeek)
/**
    Country object
    contains a name, iso country code and emoji, all strings.
*/
public struct Country {
    
    /// Name of the country
    public let name : String
    
    /// ISO country code of the country
    public let iso : String
    
    /// Emoji flag of the country
    public let emoji: String
    
}


public protocol CountryPickerDelegate : UIPickerViewDelegate {
    
    /**
     Called by the CountryPicker when the user selects a country
     
     - parameter picker:  An object representing the CounrtyPicker requesting the data.
     - parameter country: The Selected Country
     */
    func countryPicker(_ picker: CountryPicker, didSelectCountry country: Country)
}

/** 
 The CountryPicker class uses a custom subclass of UIPickerView to display country names and flags (emoji flags) in a slot machine interface. The user can choose a pick a country.
*/
open class CountryPicker : UIPickerView {
  
    /// The current picked Country
    open var pickedCountry : Country?
    
    /// The delegate for the CountryPicker
    open var countryDelegate : CountryPickerDelegate?
    
    /// The Content of the CountryPicker
    fileprivate var countryData = [Country]()
    
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
    fileprivate func loadData() {
        let bundlePath = Bundle(for: CountryPicker.self).path(forResource: "SwiftCountryPicker", ofType: "bundle")
        
        if let path = Bundle(path: bundlePath!)!.path(forResource: "EmojiCountryCodes", ofType: "json")
        {
            
            do {
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let json = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)

                var countryCode: String?
 
                if let local = (Locale.current as NSLocale).object(forKey: NSLocale.Key.countryCode) as? String {
                    countryCode = local
                }
                
                
                guard let countries = json as? NSArray else {
                    print("countries is not an array")
                    return
                }
                
                for subJson in countries{
                    
                    guard let subJson = subJson as? [String: String], let name = subJson["name"], let iso = subJson["code"], let emoji = subJson["emoji"] else {
                        
                        print("couldn't parse json")
                        
                        break
                    }
                    
                    let country = Country(name: name, iso: iso, emoji: emoji)
                    
                    // set current country if it's the local countr y
                    if country.iso == countryCode {
                        pickedCountry = country
                    }
                    
                    // append country
                    countryData.append(country)
                }
                
                countryData.sort { $1.name > $0.name }
                self.reloadAllComponents()
                
            } catch {
                print("error reading file")
                
            }
        }

    }
}

extension CountryPicker : UIPickerViewDataSource {
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(countryData[row].emoji.description) - \(countryData[row].name.description)"
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countryData.count
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

}

extension CountryPicker : UIPickerViewDelegate {

    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickedCountry = countryData[row]
        if let countryDelegate = self.countryDelegate {
            countryDelegate.countryPicker(self, didSelectCountry: countryData[row])
        }
    }

}

