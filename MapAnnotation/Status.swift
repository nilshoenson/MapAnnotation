//
//  Status.swift
//  MapAnnotation
//
//  Created by Nils Hoenson on 17/07/2023.
//

import SwiftUI

enum Status: String {
	case available, after, before
}

func getStatus(status: Status) -> Color? {
	switch status {
		case .available:
			return Colors.availableColor
		case .after:
			return Colors.unavailableColor
		case .before:
			return Colors.beforeColor
	}
}

func getStatusTitle(status: Status) -> String {
	switch status {
		case .available:
			return "At Work"
		case .after:
			return "After Work"
		case .before:
			return "Before"
	}
}
