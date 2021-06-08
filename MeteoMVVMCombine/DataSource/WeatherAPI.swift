//
//  WeatherAPI.swift
//  MeteoMVVMCombine
//
//  Created by David Grammatico on 05/06/2021.
//

import Foundation
import Combine

class WeatherAPI: WeatherProtocol, ObservableObject {
    
    private var key = "key api"
    private var session = URLSession.shared
    
    func getWeather(userLocation: UserLocation) -> AnyPublisher<WeatherResponse, WeatherIssue> {
        let lat = userLocation.lat
        let lon = userLocation.lon
        return parseWeather(urlComponents: getComponents(lat: lat, lon: lon))
    }
    
    func parseWeather<WeatherResponse: Decodable>(urlComponents: URLComponents) -> AnyPublisher<WeatherResponse, WeatherIssue> {
        guard let url = urlComponents.url else {
            let urlError = WeatherIssue.connexion(desc: "URL invalide")
            return Fail(error: urlError).eraseToAnyPublisher()
        }
        print(url)
        return session.dataTaskPublisher(for: url)
            .mapError { err in
                WeatherIssue.connexion(desc: err.localizedDescription)
            }
            .flatMap(maxPublishers: .max(1)) { output in
                self.decode(data: output.data)
            }
            .eraseToAnyPublisher()
    }
    
    func decode<WeatherResponse: Decodable>(data: Data) -> AnyPublisher<WeatherResponse, WeatherIssue> {
        return Just(data)
            .decode(type: WeatherResponse.self, decoder: JSONDecoder())
            .mapError { error in
                WeatherIssue.json(desc: "JSon invalide : \(error.localizedDescription)")
            }.eraseToAnyPublisher()
    }
    
    func getComponents(lat: Double, lon: Double) -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/2.5/forecast"
        urlComponents.queryItems = [
            URLQueryItem(name: "lat", value: String(lat)),
            URLQueryItem(name: "lon", value: String(lon)),
            URLQueryItem(name: "mode", value: "json"),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "lang", value: "fr"),
            URLQueryItem(name: "appid", value: key)
        ]
        
        return urlComponents
    }
}
