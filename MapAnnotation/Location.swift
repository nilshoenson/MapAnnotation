//
//  Location.swift
//  MapAnnotation
//
//  Created by Nils Hoenson on 18/07/2023.
//

import SwiftUI
import MapKit

struct Location: Identifiable {
	let id = UUID()
	let name: String
	let coordinate: CLLocationCoordinate2D
	let timezone: String
	let status: Status
}
