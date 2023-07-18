//
//  PrimaryButton.swift
//  MapAnnotation
//
//  Created by Nils Hoenson on 18/07/2023.
//

import SwiftUI

struct PrimaryHighlight: ButtonStyle {
	let tint: Color
	let iconOnly: Bool
	
	func makeBody(configuration: Self.Configuration) -> some View {
		configuration.label
			.padding(.horizontal, iconOnly ? 10 : 24)
			.padding(.vertical, 6)
			.frame(maxWidth: .infinity, minHeight: 24, alignment: .center)
			.overlay(
				RoundedRectangle(cornerRadius: 20)
					.stroke(Color.black.opacity(0.1), lineWidth: 2)
			)
			.background(
				ZStack {
					RoundedRectangle(cornerRadius: 20, style: .continuous)
						.fill(Colors.removeColor)
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

public struct PrimaryButton: View {
	public typealias TapHandler = (() -> Void)
	
	// MARK: Lifecycle
	public init(
		_ title: String,
		onTap: @escaping TapHandler,
		icon: String = ""
	) {
		self.title = title
		tapHandler = onTap
		self.icon = icon
	}
	
	public var title: String = ""
	public var tapHandler: TapHandler
	public var icon: String = ""
	
	public var body: some View {
		VStack {
			Button(action: {
				tapHandler()
			}){
				HStack(spacing: 10) {
					if !icon.isEmpty {
						Image(systemName: icon).font(.system(size: 17))
					}
					
					if !title.isEmpty {
						Text(title)
							.font(.system(size: 11, weight: .medium))
					}
				}
			}
			.buttonStyle(
				PrimaryHighlight(
					tint: .black,
					iconOnly: title.isEmpty
				)
			)
		}
	}
}

struct PrimaryButton_Previews: PreviewProvider {
	static var previews: some View {
		HStack(spacing: 16) {
			PrimaryButton("Remove", onTap: {
				print("Pressed!")
			})
		}
		.frame(maxWidth: 120)
		.padding()
	}
}
