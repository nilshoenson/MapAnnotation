//
//  StatusView.swift
//  MapAnnotation
//
//  Created by Nils Hoenson on 17/07/2023.
//

import SwiftUI

struct ScaleDownButton: ButtonStyle {
	func makeBody(configuration: Self.Configuration) -> some View {
		configuration.label
			.scaleEffect(configuration.isPressed ? 0.97 : 1)
			.animation(.spring(response: 0.25, dampingFraction: 0.7), value: configuration.isPressed)
	}
}

struct BlurView: UIViewRepresentable {
	typealias UIViewType = UIVisualEffectView
	
	let style: UIBlurEffect.Style
	
	init(style: UIBlurEffect.Style = .systemMaterial) { self.style = style }
	
	func makeUIView(context: Context) -> UIVisualEffectView {
		return UIVisualEffectView(effect: UIBlurEffect(style: style))
	}
	
	func updateUIView(_ uiView: UIViewType, context: Context) {
		uiView.effect = UIBlurEffect(style: style)
	}
}

struct StatusView: View {
	@State private var showFull = false
	@GestureState private var isDetectingPress = false
	
	public var name: String = ""
	public var locale: String = ""
	
	public init(_ name: String, locale: String) {
		self.name = name
		self.locale = locale
	}
	
	func getCurrentTime(locale: String) -> String {
		let formatter = DateFormatter()
		formatter.dateFormat = "HH:mm"
		formatter.timeZone = TimeZone(abbreviation: locale)
		let estDate = formatter.string(from: Date())
		
		return estDate
	}
	
	var body: some View {
		VStack(spacing: 12) {
			VStack(spacing: 6) {
				Image(self.name)
					.resizable()
					.frame(width: 44, height: 44)
					.clipShape(Circle())
				Text("Available")
					.font(.system(size: 11, weight: .medium))
					.padding(.horizontal, 6)
					.padding(.vertical, 3)
					.foregroundColor(.white)
					.background(Color(red: 0.122, green: 0.749, blue: 0.353))
					.clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
			}
			
			Text(name)
				.font(.system(size: 18, weight: .bold, design: .rounded))
				.offset(y: showFull ? 0 : 20)
			
			VStack(spacing: 8) {
				HStack {
					Text("Local Time")
						.foregroundColor(Color(red: 0.478, green: 0.478, blue: 0.478))
					Spacer()
					Text(getCurrentTime(locale: self.locale))
						.fontWeight(.bold)
						.monospacedDigit()
						.foregroundColor(Color(red: 0.149, green: 0.149, blue: 0.149))
				}

				HStack {
					Text("Meeting Time")
						.foregroundColor(Color(red: 0.478, green: 0.478, blue: 0.478))
					Spacer()
					Text("16:30")
						.fontWeight(.bold)
						.monospacedDigit()
						.foregroundColor(Color(red: 0.149, green: 0.149, blue: 0.149))
				}
			}
			.padding(10)
			.frame(width: 156)
			.tracking(-0.25)
			.font(.system(size: 11, weight: .regular, design: .rounded))
			.background(.gray.opacity(0.1))
			.clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
			.scaleEffect(showFull ? 1 : 0.2)
			.opacity(showFull ? 1 : 0)
		}
		.padding(.top, 4)
		.cornerRadius(12)
		.frame(width: showFull ? 164 : 68, height: showFull ? 178 : 77, alignment: .top)
		.background(BlurView(style: .systemMaterial))
		.clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
		.shadow(color: .black.opacity(0.15), radius: 4, x: 0, y: 2)
		.shadow(color: .black.opacity(0.18), radius: 12, x: 0, y: 18)
		.scaleEffect(isDetectingPress ? 0.94 : 1)
		.animation(.spring(response: 0.25, dampingFraction: 0.75), value: isDetectingPress)
		.gesture(
			LongPressGesture(minimumDuration: 0.1).sequenced(before:DragGesture(minimumDistance: 0))
				.updating($isDetectingPress) { value, state, _ in
					switch value {
						case .second(true, nil):
							state = true
						default:
							break
					}
				}.onEnded { _ in
					withAnimation(.spring(response: 0.48, dampingFraction: 0.8)) {
						showFull.toggle()
					}
				}
		)
	}
}

struct StatusView_Previews: PreviewProvider {
	static var previews: some View {
		StatusView("Steven", locale: "CET")
	}
}