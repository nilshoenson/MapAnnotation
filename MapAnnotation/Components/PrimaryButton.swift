//
//  PrimaryButton.swift
//  MapAnnotation
//
//  Created by Nils Hoenson on 18/07/2023.
//

import SwiftUI

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
				HStack(spacing: 8) {
					if !icon.isEmpty {
						Image(systemName: icon).font(.system(size: 14))
					}
					
					if !title.isEmpty {
						Text(title)
							.font(.system(size: 14, weight: .medium))
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
		VStack(spacing: 16) {
			PrimaryButton("Remove", onTap: {
				print("Removed!")
			})
			
			PrimaryButton("Remove", onTap: {
				print("Removed!")
			}, icon: "minus.circle.fill")
			
			PrimaryButton("", onTap: {
				print("Removed!")
			}, icon: "minus.circle.fill")
		}
		.frame(maxWidth: 140)
		.padding()
	}
}
