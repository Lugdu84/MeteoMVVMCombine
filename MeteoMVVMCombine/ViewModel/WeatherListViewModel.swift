//
//  WeatherListViewModel.swift
//  MeteoMVVMCombine
//
//  Created by David Grammatico on 05/06/2021.
//

import Foundation
import SwiftUI
import Combine

class WeatherListViewModel: ObservableObject {
    @Published var weatherList: [WeatherViewModel] = []
    @ObservedObject var api = WeatherAPI()
    var cancellable = Set<AnyCancellable>()
    
    func requestForecast(userLocation: UserLocation) {
        api.getWeather(userLocation: userLocation)
            .map { weatherResponse in
                weatherResponse.list.map { forecast in
                    WeatherViewModel(weather: forecast)
                }
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] response in
                switch response {
                    // si erreur, on ne montre rien
                    case .failure: self?.weatherList = []
                    case .finished: break
                }
            } receiveValue: { [weak self] result in
                // faible et par rapport à soit
                guard let self = self else {return} // self exist ???
                self.weatherList = result
            }
            .store(in: &cancellable) // Annulable
    }
}
