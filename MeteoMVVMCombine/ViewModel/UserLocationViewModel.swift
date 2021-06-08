//
//  UserLocationViewModel.swift
//  MeteoMVVMCombine
//
//  Created by David Grammatico on 02/06/2021.
//

import Foundation
import CoreLocation
import MapKit

class UserLocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    
    @Published var userLocation: UserLocation?
    private var manager = CLLocationManager()
    private var geo = CLGeocoder()
    var authStatus: CLAuthorizationStatus?
    @Published var showLocation: Bool = true
    
    override init() {
        super.init()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        // Distance pour actualiser les changements
        manager.distanceFilter = 1000
        updateLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(manager.authorizationStatus)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let last = locations.last else {return}
        // Convertisse en mon modele
        convertCoords(location: last)
    }
    
    func updateLocation() {
        showLocation ? manager.startUpdatingLocation() : manager.stopUpdatingLocation()
    }
    
    func toggleLcation() {
        showLocation.toggle()
        updateLocation()
    }
    
    func convertCoords (location: CLLocation) {
        geo.reverseGeocodeLocation(location, completionHandler: geoCodeCompletion(results:error:))
    }
    
    func convertAddress(address: String) {
        showLocation = false
        manager.stopUpdatingLocation()
        geo.geocodeAddressString(address, completionHandler: geoCodeCompletion(results:error:))
    }
    
    func geoCodeCompletion(results: [CLPlacemark]?, error: Error?) {
        guard let first = results?.first else {return}
        let coords = first.location?.coordinate
        let lat = coords?.latitude ?? 0
        let lon = coords?.longitude ?? 0
        let city = first.locality ?? ""
        let country = first.country ?? ""
        let newUserLocation = UserLocation(lat: lat, lon: lon, city: city, country: country)
        self.userLocation = newUserLocation
    }
    
    func setRegion(user: UserLocation) -> MKCoordinateRegion {
        let center = CLLocationCoordinate2D(latitude: user.lat, longitude: user.lon)
        let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        return MKCoordinateRegion(center: center, span: span)
    }
}
