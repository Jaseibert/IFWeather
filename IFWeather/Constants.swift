//
//  Constants.swift
//  Simplicity
//
//  Created by Jeremy Seibert on 12/18/16.
//  Copyright © 2016 Jeremy Seibert. All rights reserved.
//

import Foundation

let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
let API_KEY = "0a564d76fbb952191cc2e8b0ff10e552"

typealias DownloadComplete = () -> ()

let CURRENT_WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&appid=0a564d76fbb952191cc2e8b0ff10e552"
let FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&cnt=10&mode=json&appid=0a564d76fbb952191cc2e8b0ff10e552"
