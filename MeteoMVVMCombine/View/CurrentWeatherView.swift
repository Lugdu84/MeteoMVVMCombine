//
//  CurrentWeatherView.swift
//  MeteoMVVMCombine
//
//  Created by David Grammatico on 08/06/2021.
//

import SwiftUI

struct CurrentWeatherView: View {
    var weather: WeatherViewModel
    @ObservedObject var loader: ImageViewModel
    
    init(weather: WeatherViewModel) {
        self.weather = weather
        loader = ImageViewModel(self.weather.iconString)
    }
    var body: some View {
        VStack {
            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
                if let uiImage = loader.uiImage {
                    Image(uiImage: uiImage)
                }
                Text(weather.temperature)
                    .font(.largeTitle)
                    .foregroundColor(.green)
            })
            Text(weather.desc)
                .font(.title2)
            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
                Text(weather.min)
                Spacer()
                Text(weather.max)
            })
        }
    }
}
