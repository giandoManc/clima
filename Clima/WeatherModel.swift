//
//  WeatherModel.swift
//  Clima
//
//  Created by Giandomenico on 22/08/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionId:Int;
    var name:String;
    var temperature:Double;
    var temperatureString: String {
        return String(format: "%.1f", temperature);
    }
    var condition : String {
        switch(conditionId){
        case 200...232:
            return "cloud.bolt";
        break;
        case 300...321:
            return "cloud.drizzle";
        break;
        case 500...531:
            return "cloud.rain";
        break;
        case 600...622:
            return "cloud.snow";
        break;
        case 700...781:
            return "cloud.fog";
        break;
        case 800...801:
            return "cloud.sun";
        break;
        case 802...804:
            return "cloud.bolt";
        break;
        default:
            return "cloud";
        break;
        }

    }
}
