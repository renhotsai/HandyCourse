//
//  MapView.swift
//  CollegeApplication
//
//  Created by RENHO TSAI on 2024/3/14.
//

import SwiftUI
import MapKit

struct MyMap: UIViewRepresentable {
    typealias UIViewType = MKMapView

    let address: String // Static address

    func makeUIView(context: Context) -> MKMapView {
        let map = MKMapView(frame: .zero)
        map.mapType = .standard
        map.isZoomEnabled = true
        map.isUserInteractionEnabled = true
        map.showsUserLocation = true

        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) { placemarks, error in
            guard let placemark = placemarks?.first, let location = placemark.location else {
                return
            }

            let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 2500, longitudinalMeters: 2500)
            map.setRegion(region, animated: true)

            let mapAnnotation = MKPointAnnotation()
            mapAnnotation.coordinate = location.coordinate
            mapAnnotation.title = "Handy Course"
            map.addAnnotation(mapAnnotation)
        }

        return map
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        // No need to update the map view
    }
}
