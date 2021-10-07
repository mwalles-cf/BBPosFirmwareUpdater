//
//  BBPosManager.swift
//  BBPosFirmwareUpdater
//
//  Created by Micah A. Walles on 10/7/21.
//

import Foundation

class BBPosManager: NSObject {
	internal var returnClosure: (([Reader]) -> Void)?
	internal var connectReturnClosure: ((DeviceInformation) -> Void)?
	internal var disconnectReturnClosure: (() -> Void)?

	override init () {
		super.init()
		BBDeviceController.shared().isDebugLogEnabled = true
		BBDeviceController.shared().delegate = self
	}

	func scan(returnClosure: @escaping ([Reader]) -> Void) {
		self.returnClosure = returnClosure
		BBDeviceController.shared().startBTScan(nil, scanTimeout: 60000)
	}

	func connect(to peripheral: CBPeripheral, returnClosure: @escaping (DeviceInformation) -> Void) {
		connectReturnClosure = returnClosure
		BBDeviceController.shared().connectBT(peripheral)
	}

	func disconnct(returnClosure: @escaping () -> Void) {
		disconnectReturnClosure = returnClosure
		BBDeviceController.shared().disconnectBT()
	}

}

extension BBPosManager : BBDeviceControllerDelegate {

	func onError(errorType: BBDeviceErrorType, errorMessage: String!) {
		print(errorType, errorMessage ?? "NO ERROR MESSAGE PROVIDED")
	}

	func onBTScanStopped() {
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
		if let disconnectReturnClosure = disconnectReturnClosure {
			disconnectReturnClosure()
		}
	}

	func onRequestEnableBluetoothInSettings() {
		print("onRequestEnableBluetoothInSettings")
	}

	func onBTRequestPairing() {
		print("onBTRequestPairing")
	}

	func onReturnDeviceInfo(_ deviceInfo: [AnyHashable : Any]) {
		print(deviceInfo)
		let info = DeviceInformation(
			bID: deviceInfo["bID"] as? String ?? "",
			batteryLevel: deviceInfo["batteryLevel"] as? String ?? "",
			batteryPercentage: deviceInfo["batteryPercentage"] as? String ?? "",
			bootloaderVersion: deviceInfo["bootloaderVersion"] as? String ?? "",
			deviceSettingVersion: deviceInfo["deviceSettingVersion"] as? String ?? "",
			emvKsn: deviceInfo["emvKsn"] as? String ?? "",
			firmwareVersion: deviceInfo["firmwareVersion"] as? String ?? "",
			formatID: deviceInfo["formatID"] as? String ?? "",
			hardwareVersion: deviceInfo["hardwareVersion"] as? String ?? "",
			isCharging: deviceInfo["isCharging"] as? Bool ?? false,
			isSupportedNfc: deviceInfo["isSupportedNfc"] as? Bool ?? false,
			isSupportedSoftwarePinPad: deviceInfo["isSupportedSoftwarePinPad"] as? Bool ?? false,
			isSupportedTrack1: deviceInfo["isSupportedTrack1"] as? Bool ?? false,
			isSupportedTrack2: deviceInfo["isSupportedTrack2"] as? Bool ?? false,
			isSupportedTrack3: deviceInfo["isSupportedTrack3"] as? Bool ?? false,
			isUsbConnected: deviceInfo["isUsbConnected"] as? Bool ?? false,
			macKsn: deviceInfo["macKsn"] as? String ?? "",
			pinKsn: deviceInfo["pinKsn"] as? String ?? "",
			productID: deviceInfo["productID"] as? String ?? "",
			sdkVersion: deviceInfo["sdkVersion"] as? String ?? "",
			serialNumber: deviceInfo["serialNumber"] as? String ?? "",
			terminalSettingVersion: deviceInfo["terminalSettingVersion"] as? String ?? "",
			trackKsn: deviceInfo["trackKsn"] as? String ?? "",
			uid: deviceInfo["uid"] as? String ?? "",
			vendorID: deviceInfo["vendorID"] as? String ?? "")
		if let connectReturnClosure = connectReturnClosure {
			connectReturnClosure(info)
		} else {
//			throw error
		}
	}
}
