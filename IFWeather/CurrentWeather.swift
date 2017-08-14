//
//  CurrentWeather.swift
//  Simplicity
//
//  Created by Jeremy Seibert on 12/18/16.
//  Copyright © 2016 Jeremy Seibert. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeather {
    var _cityName: String!
    var _date: String!
    var _weatherType: String!
    var _currentTemp: String!
    var _maxTemp: String!
    var _minTemp: String!
    
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = currentDate
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemp: String {
        if _currentTemp == nil {
            _currentTemp = "\(0)"
        }
        return _currentTemp
    }
    
    var minTemp: String {
        if _minTemp == nil {
            _minTemp = "\(0)"
        }
        return _minTemp
    }
    var maxTemp: String {
        if _maxTemp == nil {
            _maxTemp = "\(0)"
        }
        return _maxTemp
    }
    
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete) {
        //Download Current Weather Data
        Alamofire.request(CURRENT_WEATHER_URL).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let name = dict["name"] as? String {
                    self._cityName = name.capitalized
                    print(self._cityName)
                }
                
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] {
                    
                    if let main = weather[0]["main"] as? String {
                        self._weatherType = main.localizedLowercase
                        print(self._weatherType)
                    }
                    
                }
                
                if let main = dict["main"] as? Dictionary<String, AnyObject> {
                    
                    if let currentTemperature = main["temp"] as? Double {
                        
                        let kelvinToFarenheitPreDivision = (currentTemperature * (9/5) - 459.67)
                        
                        let kelvinToFarenheit = Int(round(10 * kelvinToFarenheitPreDivision/10))
                        
                        let currentDisplayTemp = "\(kelvinToFarenheit)°"
                        
                        self._currentTemp = currentDisplayTemp
                        print(self._currentTemp)
                    }
                }
                
                if let main = dict["main"] as? Dictionary<String,AnyObject> {
                    
                    if let minimunTemperature = main["temp_min"] as? Double {
                        
                        let kelvinToFarenheitPreDivision = (minimunTemperature * (9/5) - 459.67)
                        
                        let kelvinToFarenheit = Int(round(10 * kelvinToFarenheitPreDivision/10))
                        
                        let currentMinimumTemp = "\(kelvinToFarenheit)°"
                        
                        self._minTemp = currentMinimumTemp
                        print(self._minTemp)
                    }
                }
                
                if let main = dict["main"] as? Dictionary<String, AnyObject> {
                    
                    if let maximumTemperature = main["temp_max"] as? Double {
                        
                        let kelvinToFarenheitPreDivision = (maximumTemperature * (9/5) - 459.67)
                        
                        let kelvinToFarenheit = Int(round(10 * kelvinToFarenheitPreDivision/10))
                        
                        let currentMaximumTemp = "\(kelvinToFarenheit)°"
                        
                        self._maxTemp = currentMaximumTemp
                        print(self._maxTemp)
                    }
                }
                
            completed()
            }
        }
    }
}
