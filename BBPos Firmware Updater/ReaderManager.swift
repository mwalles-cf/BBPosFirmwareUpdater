//
//  ReaderManager.swift
//  BBPos Firmware Updater
//
//  Created by Micah A. Walles on 9/29/21.
//

import Foundation

struct ReaderManager {
	private static let manager = BBPosManager()
	private static let otaManager = BBPosOTAManager()

	static func scan(returnClosure: @escaping ([Reader]) -> Void) {
		manager.scan(returnClosure: returnClosure)
	}

	static func connect(peripheral: CBPeripheral, returnClosure: @escaping (DeviceInformation) -> Void) {
		manager.connect(to: peripheral, returnClosure: returnClosure)
	}

	static func disconnect(returnClosure: @escaping () -> Void) {
		manager.disconnct(returnClosure: returnClosure)
	}

	static func updateFirmware(to version: String) {
		//FIXME: need closure for when it is finished and one for progress
		otaManager.updateFirmware(to: version)
	}
}



//extension BBPosManager : BBDeviceOTAControllerDelegate {
//}


