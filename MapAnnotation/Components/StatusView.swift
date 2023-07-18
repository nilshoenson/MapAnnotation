//
//  StatusView.swift
//  MapAnnotation
//
//  Created by Nils Hoenson on 17/07/2023.
//

import SwiftUI

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
	@State private var meetingState = "available"
	@GestureState private var isDetectingPress = false
	
	public var name: String = ""
	public var locale: String = ""
	public var status: Status = .available
	
	public init(
		_ name: String,
		locale: String,
		status: Status
	) {
		self.name = name
		self.locale = locale
		self.status = status
	}
	
	func getCurrentTime(locale: String) -> String {
		let formatter = DateFormatter()
		formatter.dateFormat = "HH:mm"
		formatter.timeZone = TimeZone(abbreviation: locale)
		let estDate = formatter.string(from: Date())
		
		return estDate
	}
	
	func convertFromCET(locale: String) -> String {
		let dateStr = "2023-07-17T14:30:00.000+02:00"
		
		// Format string to to Date
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd\'T\'HH:mm:ss\'.000\'z"
		dateFormatter.timeZone = TimeZone(abbreviation: locale)
		let date = dateFormatter.date(from: dateStr)
		
		// Format string to prettier string
		dateFormatter.dateFormat = "HH:mm"
		dateFormatter.timeZone = TimeZone(abbreviation: locale)
		let estDate = dateFormatter.string(from: date!)
		
		return estDate
	}
	
	var body: some View {
		VStack(spacing: 12) {
			VStack(spacing: 6) {
				Image(self.name)
					.resizable()
					.frame(width: 44, height: 44)
					.clipShape(Circle())
				Text(getStatusTitle(status: status))
					.font(.system(size: 11, weight: .medium))
					.padding(.horizontal, 6)
					.padding(.vertical, 3)
					.foregroundColor(.white)
					.frame(width: 70)
					.background(getStatus(status: status))
					.clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
			}
			
			Text(name)
				.font(.system(size: 18, weight: .bold, design: .rounded))
				.offset(y: showFull ? 0 : 20)
				.opacity(showFull ? 1 : 0)
			
			VStack(spacing: 8) {
				RowView(label: "Local Time", value: getCurrentTime(locale: self.locale))
				RowView(label: "Meeting Time", value: convertFromCET(locale: self.locale))
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
		.frame(width: showFull ? 164 : 76, height: showFull ? 178 : 77, alignment: .top)
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
					withAnimation(.spring(response: 0.46, dampingFraction: 0.8)) {
						showFull.toggle()
					}
				}
		)
	}
}

struct StatusView_Previews: PreviewProvider {
	static var previews: some View {
		StatusView("Steven", locale: "CET", status: .available)
	}
}
