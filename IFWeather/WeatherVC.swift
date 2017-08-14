//
//  WeatherVC.swift
//  IFWeather
//
//  Created by Jeremy Seibert on 4/6/17.
//  Copyright © 2017 Jeremy Seibert. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class WeatherVC: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var currentWeatherLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentMinimumTemp: UILabel!
    @IBOutlet weak var currentMaximumTemp: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    
    var currentWeather: CurrentWeather!
    var forecast: Forecast!
    var forecasts = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        currentWeather = CurrentWeather()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
                currentWeather.downloadWeatherDetails {
                self.downloadForecastData {
                    self.updateMainUI()
                }
            }
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    func downloadForecastData(completed: @escaping DownloadComplete) {
        //Downloading forecast weather data for TableView
        Alamofire.request(FORECAST_URL).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    
                    for obj in list {
                        let forecast = Forecast(weatherDict: obj)
                        self.forecasts.append(forecast)
                        self.currentMaximumTemp.text = "\(forecast.highTemp)°"
                        self.currentMinimumTemp.text = "\(forecast.lowTemp)°"
                        self.dayLabel.text = "\(forecast.date)"
                        print(obj)
                    }
                }
            }
            completed()
        }
    }
    
    //Update the User Interface (Weather type, Weather Image, & Temperature) 
        func updateMainUI() {
            
            currentTempLabel.text = "\(currentWeather.currentTemp)"
            locationLabel.text = currentWeather.cityName
            
            
      if currentWeather.weatherType == "clear" {
            currentWeatherLabel.text = "The sky is fucking clear today."
      } else {
            if currentWeather.weatherType == "rain" || currentWeather.weatherType == "thunderstorm" {
                currentWeatherLabel.text = "Today its fucking \(currentWeather.weatherType)ing."
            } else {
                if currentWeather.weatherType == "clouds" {
                    currentWeatherLabel.text = "Today it's fucking cloudy"
                } else {
                    if currentWeather.weatherType == "drizzle" {
                        currentWeatherLabel.text = "Yes, its fucking drizzling."
                    }  else {
                        print("Nothing Happened Jackass")
                    }
                }
            }
        }
    }
}
