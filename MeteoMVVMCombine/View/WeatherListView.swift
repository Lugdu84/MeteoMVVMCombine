//
//  WeatherListView.swift
//  MeteoMVVMCombine
//
//  Created by David Grammatico on 08/06/2021.
//

import SwiftUI

struct WeatherListView: View {
    private let weather: WeatherViewModel
    @ObservedObject var imageVM: ImageViewModel
    
    init(weather: WeatherViewModel) {
        self.weather = weather
        self.imageVM = ImageViewModel(self.weather.iconString)
    }
    
    var body: some View {
        VStack {
            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
                Text(weather.temperature)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                Spacer()
                if imageVM.uiImage != nil {
                    Image(uiImage: imageVM.uiImage!)
                }
                Spacer()
                Text(weather.dateString)
                    .font(.callout)
                    .foregroundColor(.green)
                Text(weather.heureString)
                    .font(.callout)
                    .foregroundColor(.green)
            })
            
            
            Text(weather.desc)
            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
                Text(weather.min)
                Spacer()
                Text(weather.max)
            })
        }.frame(height: 100)
    }
    
}
