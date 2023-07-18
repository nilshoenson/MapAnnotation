//
//  ButtonStyles.swift
//  MapAnnotation
//
//  Created by Nils Hoenson on 18/07/2023.
//

import SwiftUI

struct ScaleDownButton: ButtonStyle {
	func makeBody(configuration: Self.Configuration) -> some View {
		configuration.label
			.scaleEffect(configuration.isPressed ? 0.96 : 1)
			.animation(.spring(response: 0.25, dampingFraction: 0.7), value: configuration.isPressed)
	}
}

struct PrimaryHighlight: ButtonStyle {
	let tint: Color
	let iconOnly: Bool
	
	func makeBody(configuration: Self.Configuration) -> some View {
		configuration.label
			.padding(.horizontal, iconOnly ? 10 : 20)
			.padding(.vertical, 6)
			.frame(maxWidth: .infinity, minHeight: 32, alignment: .center)
			.overlay(
				RoundedRectangle(cornerRadius: 20)
					.stroke(Color.black.opacity(0.1), lineWidth: 2)
			)
			.background(
				ZStack {
					RoundedRectangle(cornerRadius: 20, style: .continuous)
						.fill(Colors.primaryColor)
					RoundedRectangle(cornerRadius: 20, style: .continuous)
						.fill(tint).opacity(configuration.isPressed ? 0.12 : 0)
				}
			)
		
			.cornerRadius(20)
			.foregroundColor(.white)
			.scaleEffect(configuration.isPressed ? 0.97: 1)
			.animation(.spring(response: 0.25, dampingFraction: 0.76), value: configuration.isPressed)
	}
}
