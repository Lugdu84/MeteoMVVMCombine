//
//  TopView.swift
//  MeteoMVVMCombine
//
//  Created by David Grammatico on 02/06/2021.
//

import SwiftUI
import MapKit

struct TopView: View {
    var weather: WeatherViewModel?
    @Binding var region: MKCoordinateRegion
    var width: CGFloat
    @Binding var smallMap: Bool
    var body: some View {
        HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
            if (!smallMap) {
                if weather != nil {
                    CurrentWeatherView(weather: weather!)
                }
            }
            Spacer()
            Map(coordinateRegion: $region)
                .frame(width: sizeIt(), height: sizeIt(), alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
        })
    }
    
    func sizeIt() -> CGFloat {
       return CGFloat(smallMap ? width * 0.8 : width * 0.3)
    }
}
