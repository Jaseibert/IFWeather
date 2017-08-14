//
//  Location.swift
//  Simplicity
//
//  Created by Jeremy Seibert on 12/19/16.
//  Copyright © 2016 Jeremy Seibert. All rights reserved.
//

import CoreLocation

class Location {
    static var sharedInstance = Location()
    private init() {}
    
    var latitude: Double!
    var longitude: Double!
}
