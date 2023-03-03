//
//  WeatherBrain.swift
//  Clima
//
//  Created by Giandomenico on 22/08/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation
protocol WeatherModelDelagete {
    func didUpddateWeather(_ weatherBrain:WeatherBrain,weather: WeatherModel)
}

struct WeatherBrain {
    let waetherUrl = "https://api.openweathermap.org/data/2.5/weather?appid=59859170f511eb8bfec022bac29c9f9a&lang=it&units=metric";
    
    var delagete: WeatherModelDelagete?
    func fetchWeather(cityName:String) {
        let url = "\(waetherUrl)&q=\(cityName)";
        print(url);
        perforRequest(url:url);
    }
    
    func fetchWeather(lat: CLLocationDegrees,lon:CLLocationDegrees) {
        let url = "\(waetherUrl)&lat=\(lat)&lon=\(lon)";
        print(url);
        perforRequest(url:url);

    }
    
    func perforRequest(url:String) {
        if let url = URL(string:url){
            let session = URLSession(configuration: .default);
            let task = session.dataTask(with: url, completionHandler: handle(data: urlRespose: error:))
            task.resume();
        }
    }
    
    func handle(data:Data?,urlRespose:URLResponse?,error:Error?){
        if(error != nil) {
            print(error!);
            return;
        }
        if let safeDate = data {
            if let weather = parJson(weatherDate: safeDate){
                self.delagete?.didUpddateWeather(self,weather: weather)
            }
        }
    }
    func parJson(weatherDate:Data) -> WeatherModel?{
        let decoder = JSONDecoder();
        do {
            let decode = try decoder.decode(WeatherDate.self, from: weatherDate);
            let id = decode.weather[0].id;
            let name = decode.name;
            let main = decode.main.temp;
            let weather = WeatherModel(conditionId: id, name: name, temperature: main);
            return weather
        } catch{
            print(error);
            return nil
        }
    }
    
}
