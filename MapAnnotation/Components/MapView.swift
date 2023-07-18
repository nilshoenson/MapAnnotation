//
//  MapView.swift
//  MapAnnotation
//
//  Created by Nils Hoenson on 18/07/2023.
//

import SwiftUI
import MapKit

struct MapView: View {
	@Environment(\.dismiss) var dismiss
	@State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 52.080, longitude: 4.309), span: MKCoordinateSpan(latitudeDelta: 16, longitudeDelta: 16))
	
	let locations = [
		Location(name: "Michael", coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141), timezone: "BST", status: .available),
		Location(name: "Dennis", coordinate: CLLocationCoordinate2D(latitude: -33.918, longitude: 18.423), timezone: "SAST", status: .available),
		Location(name: "Steven", coordinate: CLLocationCoordinate2D(latitude: 40.730, longitude: -73.935), timezone: "EST", status: .before),
		Location(name: "Grace", coordinate: CLLocationCoordinate2D(latitude: 35.652, longitude: 139.839), timezone: "JST", status: .after),
		Location(name: "Nils", coordinate: CLLocationCoordinate2D(latitude: 52.080, longitude: 4.309), timezone: "CET", status: .available),
		Location(name: "Jane", coordinate: CLLocationCoordinate2D(latitude: 37.773, longitude: -122.431), timezone: "PDT", status: .before)
	]
	
	var body: some View {
		ZStack {
			Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
				MapAnnotation(coordinate: location.coordinate) {
					StatusView(location.name, locale: location.timezone, status: location.status)
				}
			}.ignoresSafeArea()
			
			GeometryReader { geometry in
				HStack {
					Spacer()
					Button("Dismiss", action: {
						dismiss()
					})
						.padding(8)
						.font(.system(size: 14, weight: .regular, design: .rounded))
						.foregroundColor(Colors.textColorDark)
						.background(BlurView(style: .systemMaterial))
						.clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
						.buttonStyle(ScaleDownButton())
				}
				.padding(.top, 12)
				.padding(.trailing, 12)
			}
		}
	}
}

struct MapView_Previews: PreviewProvider {
	static var previews: some View {
		MapView()
	}
}

