//
//  ReaderModel.swift
//  BBPosFirmwareUpdater
//
//  Created by Micah A. Walles on 10/6/21.
//

import Foundation

enum RederModel {
	case chb10
	case chb20
	case unknown

	init(serial: String) {
		let model = String(serial.prefix(5)).uppercased()
		if model == "CHB10" {
			self = .chb10
		} else if model == "CHB20" {
			self = .chb20
		} else {
			self = .unknown
		}
	}

	func updateVersion(for currentVersion: String) -> String {
		switch self {
		case .chb10:
			if currentVersion == "1.00.03.35" {
				return "1.00.03.34"
			} else {
				return "1.00.03.35"
			}
		case .chb20:
			if currentVersion == "1.00.02.27.f976e5dd" {
				return "1.00.02.24"
			} else {
				return "1.00.02.27.f976e5dd"
			}
		case .unknown:
			return "unknown"
		}
	}
}
