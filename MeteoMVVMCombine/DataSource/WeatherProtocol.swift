//
//  WeatherProtocol.swift
//  MeteoMVVMCombine
//
//  Created by David Grammatico on 05/06/2021.
//

import Foundation
import Combine

protocol WeatherProtocol {

    
    func getWeather(userLocation: UserLocation) -> AnyPublisher<WeatherResponse, WeatherIssue>
}
