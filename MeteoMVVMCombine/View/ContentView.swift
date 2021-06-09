//
//  ContentView.swift
//  MeteoMVVMCombine
//
//  Created by David Grammatico on 02/06/2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var location: UserLocationViewModel = UserLocationViewModel()
    @ObservedObject var weatherList: WeatherListViewModel = WeatherListViewModel()
    @State var bool = false
    @State var text = ""
    var body: some View {
        if (location.userLocation == nil) {
            Text("Attente des données")
                .padding()
        } else {
            GeometryReader { geo in
                NavigationView {
                    
                    List {
                        TopView( weather: weatherList.weatherList.first, region: .constant(location.setRegion(user: location.userLocation!)), width: geo.size.width, smallMap: $bool)
                            .onTapGesture {
                                self.bool.toggle()
                            }
                        HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
                            TextField("Ajoutez une ville", text: $text)
                            Button(action: {
                                location.convertAddress(address: text)
                                UIApplication.shared.endEditing()
                            }, label: {
                                Image(systemName: "paperplane.fill")
                                    .foregroundColor(.green)
                            })
                        })
                        Section(header: Text("Prévisions"), content: {
                            ForEach(weatherList.weatherList) { weatherVM in
                                WeatherListView(weather: weatherVM)
                            }
                        })
                        
                    }
                    .animation(.linear)
                    .navigationTitle(location.userLocation!.city)
                    .navigationBarItems(trailing: Button(action: {
                        location.toggleLcation()
                    }, label: {
                        Image(systemName: (location.showLocation) ? "location.fill" : "location.slash.fill")
                    }))
                    
                }
                .onAppear() {
                    changeCity()
                }
                .onChange(of: location.userLocation?.city, perform: { newValue in
                    changeCity()
                })
            }
            
        }
        
    }
    
    func changeCity() {
        if let user = location.userLocation {
            weatherList.requestForecast(userLocation: user)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
