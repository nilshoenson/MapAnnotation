//
//  ContentView.swift
//  MapAnnotation
//
//  Created by Nils Hoenson on 17/07/2023.
//

import SwiftUI
import MapKit

struct ContentView: View {
	@State private var showModal = false
	@State private var shouldAnimate = false
	
	var body: some View {
		NavigationView {
			ScrollView {
				VStack(spacing: 16) {
					RowView(label: "Date", value: "Tomorrow")
					RowView(label: "From (CET)", value: "14:30")
					RowView(label: "To (CET)", value: "15:30")
					RowView(label: "Location", value: "Cape Town, South Africa")
					RowView(label: "Guests", value: "Cape Town, South Africa", src: "All")
					Divider()
						.padding(.vertical, 12)
					Text("You are inviting guests from different timezones into your meeting. Check to see if the current date fits their work schedule.")
						.foregroundColor(Colors.textColorLight)
						.multilineTextAlignment(.center)
						.padding(.bottom, 6)
					
					PrimaryButton("View Timezones", onTap: {
						showModal.toggle()
					})
					.frame(width: 146)
				}
				.padding(20)
				.frame(maxWidth: .infinity)
				.tracking(-0.25)
				.font(.system(size: 16, weight: .regular, design: .rounded))
				.background(.gray.opacity(0.1))
				.clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
				.offset(y: shouldAnimate ? 16 : 46)
				.opacity(shouldAnimate ? 1 : 0)
				.scaleEffect(shouldAnimate ? 1 : 0.96)
			}
			.onAppear {
				withAnimation(
					.spring(response: 0.6, dampingFraction: 0.65, blendDuration: 8.0)
					.delay(0.25)
				) {
					shouldAnimate = true
				}
			}
			.padding(.horizontal)
			.navigationTitle("Weekly Standup")
		}
		.sheet(isPresented: $showModal, content: {
			MapView()
		})
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
