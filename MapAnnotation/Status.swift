//
//  Status.swift
//  MapAnnotation
//
//  Created by Nils Hoenson on 17/07/2023.
//

import SwiftUI

enum Status: String {
	case available = "available"
	case after = "after"
	case before = "before"
}

func getStatus(status: Status) -> Color? {
	switch status.rawValue {
		case "available":
			return Colors.availableColor
		case "after":
			return Colors.unavailableColor
		case "before":
			return Colors.beforeColor
		default:
			return nil
	}
}

func getStatusTitle(status: Status) -> String {
	switch status.rawValue {
		case "available":
			return "At Work"
		case "after":
			return "After Work"
		case "before":
			return "Before"
		default:
			return ""
	}
}
