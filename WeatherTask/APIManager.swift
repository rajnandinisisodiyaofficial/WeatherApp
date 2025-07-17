//
//  APIManager.swift
//  WeatherTask
//
//  Created by RajNandini on 15/07/25.
//
import Foundation
import Alamofire

class APIManager {
    
    static var shared : APIManager = APIManager()
    
    var imageBaseURL = "https://openweathermap.org/img/wn/"
    var baseURL = "https://api.openweathermap.org/data/2.5/weather"
    
    func loadCities()-> [City]{
        guard let url = Bundle.main.url(forResource: "cities", withExtension: "json") else {
               print("JSON file not found")
               return []
           }
           do {
               let data = try Data(contentsOf: url)
               let cities = try JSONDecoder().decode([City].self, from: data)
               return cities
           } catch {
               print("Error decoding JSON: \(error)")
               return []
           }
    }

    func fetchWeather(lat: String, lon: String, completion: @escaping (WeatherResponse?) -> Void) {
        let url = "https://api.openweathermap.org/data/2.5/weather"
        let parameters: [String: Any] = [
            "lat": lat,
            "lon": lon,
            "appid": "409cf47076f7ea6d285bba4f5903af9d", // Use your real key
        ]
        
        AF.request(url, parameters: parameters)
            .validate()
            .responseDecodable(of: WeatherResponse.self) { response in
                switch response.result {
                case .success(let weatherData):
                    completion(weatherData)
                case .failure(let error):
                    print("API Error:", error.localizedDescription)
                    completion(nil)
                }
            }
    }

}
