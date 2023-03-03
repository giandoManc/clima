//
//  WeatherDate.swift
//  Clima
//
//  Created by Giandomenico on 22/08/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

struct WeatherDate: Decodable {
    let name:String;
    let main:Main;
    let weather:[Weather];
}

struct Main: Decodable {
    let temp:Double;
}

struct Weather: Decodable {
    let id:Int;
    let main:String;
    let description:String;
    let icon:String;
}
