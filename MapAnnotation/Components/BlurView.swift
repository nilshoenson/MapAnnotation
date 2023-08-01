//
//  BlurView.swift
//  MapAnnotation
//
//  Created by Nils Hoenson on 01/08/2023.
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
