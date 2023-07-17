//
//  ContentView.swift
//  MapAnnotation
//
//  Created by Nils Hoenson on 17/07/2023.
//

import SwiftUI
import MapKit

struct Location: Identifiable {
	let id = UUID()
	let name: String
	let coordinate: CLLocationCoordinate2D
	let timezone: String
}

struct ContentView: View {
	@State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12), span: MKCoordinateSpan(latitudeDelta: 15, longitudeDelta: 15))

	let locations = [
		Location(name: "Michael", coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141), timezone: "BST"),
		Location(name: "Dennis", coordinate: CLLocationCoordinate2D(latitude: 52.520, longitude: 13.40), timezone: "CET"),
		Location(name: "Steven", coordinate: CLLocationCoordinate2D(latitude: 40.730, longitude: -73.935), timezone: "EST"),
		Location(name: "Grace", coordinate: CLLocationCoordinate2D(latitude: 35.652, longitude: 139.839), timezone: "JST")
	]
	
	var body: some View {
		Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
			MapAnnotation(coordinate: location.coordinate) {
				StatusView(location.name, locale: location.timezone)
			}
		}
			.ignoresSafeArea()
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
