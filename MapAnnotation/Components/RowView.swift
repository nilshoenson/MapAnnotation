//
//  RowView.swift
//  MapAnnotation
//
//  Created by Nils Hoenson on 18/07/2023.
//

import SwiftUI

struct RowView: View {
	let label: String
	let value: String
	var src: String?
	
	var body: some View {
		HStack(alignment: .center) {
			Text(label)
				.foregroundColor(Colors.textColorLight)
			Spacer()
			if (src != nil) {
				Image(src ?? "")
			} else {
				Text(value)
					.fontWeight(.bold)
					.monospacedDigit()
					.foregroundColor(Colors.textColorDark)
			}
		}
	}
}

struct RowView_Previews: PreviewProvider {
	static var previews: some View {
		RowView(label: "From (CET)", value: "14:30", src: "All")
	}
}
