//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchText: UITextField!
    
    var weather = WeatherBrain();
    let locationManager = CLLocationManager();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self;
        locationManager.requestWhenInUseAuthorization();
        locationManager.requestAlwaysAuthorization();
        locationManager.requestLocation();
        
        weather.delagete = self;
        searchText.delegate = self;
        
        
        // Do any additional setup after loading the view.
    }

    @IBAction func addLocation(_ sender: Any) {
        locationManager.requestLocation();
    }
}
// MARK: - Text Filed Delegate
extension WeatherViewController:UITextFieldDelegate {
    @IBAction func searchClick(_ sender: UIButton) {
        searchText.endEditing(true);
        print(searchText.text ?? "");
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchText.endEditing(true);
        print(searchText.text ?? "");
        return true;
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchText.text {
            weather.fetchWeather(cityName: city);
        }
        searchText.text = "";
    }

}
// MARK: - Weather Model Delagete

extension WeatherViewController:WeatherModelDelagete {
    
    func didUpddateWeather(_ weatherBrain:WeatherBrain,weather:WeatherModel){
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString;
            self.conditionImageView.image = UIImage(systemName: weather.condition);
            self.cityLabel.text = weather.name;
        }
    }
    
}


// MARK: - Location

extension WeatherViewController:CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let lat = location.coordinate.latitude;
            let lon = location.coordinate.longitude;
            weather.fetchWeather(lat: lat,lon:lon);
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error);
    }
}
