//
//  ViewControllerViewModal.swift
//  WeatherTask
//
//  Created by RajNandini on 15/07/25.
//

import Foundation


class WeatherViewControllerViewModel{
    
    var allCities : [City]!
    
    var controller : WeatherViewController!
    
    var filteredCities : [City] = []{
        didSet{
            controller.tableView.beginUpdates()
            controller.tableView.reloadSections([1], with: .automatic)
            controller.tableView.endUpdates()
        }
    }
    
    var selectedCityWeather : WeatherResponse?
    
    var selectedCity : City? = nil{
        didSet{
            controller.tableView.reloadData()
        }
    }
    
    init(controller : WeatherViewController) {
        allCities = APIManager.shared.loadCities()
        self.controller = controller
    }
    
    func setWeatherForSelectedCity(weather : WeatherResponse){
        self.selectedCityWeather = weather
    }
    
    
    func resetData(){
        selectedCityWeather = nil
        selectedCity = nil
    }
    
    func fetchWeather() {
        guard let lat = selectedCity?.lat,
              let lon = selectedCity?.lon else { return }

        APIManager.shared.fetchWeather(lat: lat, lon: lon) { [weak self] response in
            guard let self = self else { return }
            self.selectedCityWeather = response
            DispatchQueue.main.async {
                self.controller.updateWeatherView()
                if self.controller.refreshControl.isRefreshing{
                    self.controller.refreshControl.endRefreshing()
                }
            }
        }
    }
    
}
