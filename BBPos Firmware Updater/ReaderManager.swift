//
//  ReaderManager.swift
//  BBPos Firmware Updater
//
//  Created by Micah A. Walles on 9/29/21.
//

import Foundation

struct ReaderManager {
	private static let manager = BBPosManager()
//	private static let connection = ReaderConnection()

	static func scan(returnClosure: @escaping ([Reader]) -> Void) {
//		ReaderScanner(completionHandler: returnClosure).scan()
		manager.scan(returnClosure: returnClosure)
	}

	static func connect(peripheral: CBPeripheral, returnClosure: @escaping ([String: String]) -> Void) {
		manager.connect(to: peripheral, returnClosure: returnClosure)
	}
}


class BBPosManager: NSObject {
	internal var returnClosure: (([Reader]) -> Void)?
	internal var connectReturnClosure: (([String: String]) -> Void)?

	override init () {
		super.init()
		BBDeviceController.shared().delegate = self
	}

	func scan(returnClosure: @escaping ([Reader]) -> Void) {
		self.returnClosure = returnClosure
		BBDeviceController.shared().startBTScan(nil, scanTimeout: 60000)
	}

	func connect(to peripheral: CBPeripheral, returnClosure: @escaping ([String: String]) -> Void) {
		connectReturnClosure = returnClosure
		BBDeviceController.shared().delegate = self
		BBDeviceController.shared().connectBT(peripheral)
	}

	func disconnct() {
		// FIXME: will need a closure
		BBDeviceController.shared().disconnectBT()
	}

}

extension BBPosManager : BBDeviceControllerDelegate {

	func onError(errorType: BBDeviceErrorType, errorMessage: String!) {
		print(errorType, errorMessage ?? "NO ERROR MESSAGE PROVIDED")
	}

	func onBTScanStopped() {
		BBDeviceController.shared().delegate = nil
		print("Scan Stopped")
	}

	func onBTScanTimeout() {
		print("Timed Out")
	}

	func onBTReturnScanResults(_ devices: [Any]!) {
		let readers = devices.compactMap {
			$0 as? CBPeripheral
		}.map {
			Reader(peripheral: $0)
		}
		if let returnClosure = returnClosure {
			returnClosure(readers)
			BBDeviceController.shared().stopBTScan()
			self.returnClosure = nil
		} else {
//			throw error
		}
	}

	//----------------------

	func onConnectBT(_ device: NSObject) {
		print("onConnectBT")
	}

	func onBTConnected(_ connectedDevice: NSObject!) {
		print("onBTConnected")
		BBDeviceController.shared().getDeviceInfo()
	}

	func onBTDisconnected() {
		print("onBTDisconnected")
	}

	func onRequestEnableBluetoothInSettings() {
		print("onRequestEnableBluetoothInSettings")
	}

	func onBTRequestPairing() {
		print("onBTRequestPairing")
	}

	func onReturnDeviceInfo(deviceInfo: Dictionary<String, Any>) {
		print(deviceInfo)
	}
}

class ReaderConnection: NSObject {
}

extension ReaderConnection: BBDeviceControllerDelegate {

	func onError(errorType: BBDeviceErrorType, errorMessage: String!) {
		print(errorType, errorMessage ?? "NO ERROR MESSAGE PROVIDED")
	}

}

//extension BBPosManager : BBDeviceOTAControllerDelegate {
//
//}
