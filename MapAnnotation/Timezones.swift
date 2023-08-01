//
//  Timezones.swift
//  MapAnnotation
//
//  Created by Nils Hoenson on 01/08/2023.
//

import Foundation

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
	let date = dateFormatter.date(from: dateStr) ?? Date()
	
	// Format string to prettier string
	dateFormatter.dateFormat = "HH:mm"
	dateFormatter.timeZone = TimeZone(abbreviation: locale)
	let estDate = dateFormatter.string(from: date)
	
	return estDate
	}
