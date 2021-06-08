//
//  WeatherViewModel.swift
//  MeteoMVVMCombine
//
//  Created by David Grammatico on 05/06/2021.
//

import Foundation

class WeatherViewModel: Identifiable {
    var id = UUID()
    private let weather:Forecast
    
    init(weather: Forecast) {
        self.weather = weather
    }
    
    var timestamp: TimeInterval {
        return TimeInterval(weather.dt)
    }
    
    var temperature: String {
        return weather.main.temp.toTemp()
    }
    
    var min: String {
        return weather.main.temp_min.toTempWithValue(value: "min : ")
    }
    
    var max: String {
        return weather.main.temp_max.toTempWithValue(value: "max : ")
    }
    
    var mainDesc: String {
        return weather.weather.first?.main ?? ""
    }
    
    var desc: String {
        return weather.weather.first?.description ?? ""
    }
    
    var iconString: String {
        return weather.weather.first?.icon ?? ""
    }
    
    var dateString: String {
        let formatter = DateFormatter()
        let date = Date(timeIntervalSince1970: timestamp)
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

extension Double {
    func toTemp() -> String {
        let int: Int = Int(self)
        let celcius = "°C"
        return String(int) + celcius
    }
    
    func toTempWithValue(value: String) -> String{
        return value + self.toTemp()
    }
}
