//
//  BBPosOTAController.swift
//  BBPosFirmwareUpdater
//
//  Created by Micah A. Walles on 10/7/21.
//

import Foundation

class BBPosOTAManager: NSObject {

	override init() {
		super.init()
		BBDeviceOTAController.shared().delegate = self
		BBDeviceOTAController.shared().setBBDevice(BBDeviceController.shared())
		BBDeviceOTAController.shared().setOTAServerURL(URL(string: "https://api.emms.bbpos.com/"))
		BBDeviceOTAController.shared().isDebugLogEnabled = true
	}

	func updateFirmware(to version: String) {
		let inputData: [AnyHashable : Any] = [
			"vendorID": "bbpos1",
			"vendorSecret": "bbpos1",
			"appID": "bbpos2",
			"appSecret": "bbpos2",
			"listType": NSNumber(integerLiteral: Int(BBDeviceTargetVersionType.firmware.rawValue)),
			"firmwareVersion": version
		]

		BBDeviceOTAController.shared().setTargetVersionWithData(inputData)
	}
//	NSMutableDictionary *inputData = [NSMutableDictionary dictionary];
//	[inputData setObject:@"bbpos1" forKey:@"vendorID"];
//	[inputData setObject:@"bbpos1" forKey:@"vendorSecret"];
//	[inputData setObject:@"bbpos2" forKey:@"appID"];
//	[inputData setObject:@"bbpos2" forKey:@"appSecret"];
//
//	// 3a. Set firmware target version via BBDeviceOTA API (Non-PCI product only)
//	[inputData setObject:[NSNumber numberWithInt:(int)BBDeviceTargetVersionType_Firmware forKey:@"listType"];
//	[inputData setObject:@"x.x.x.x" forKey:@"firmwareVersion"];
//	[[BBDeviceOTAController sharedController] setTargetVersionWithData:inputData];
//	// 4. Start one of the three OTA functions:
//	[[BBDeviceOTAController sharedController] startRemoteFirmwareUpdateWithData:inputData];
}

extension BBPosOTAManager: BBDeviceOTAControllerDelegate {
	func onReturnOTAProgress(_ percentage: Float) {

	}

	func onReturnSetTargetVersionResult(_ result: BBDeviceOTAResult, responseMessage: String!) {

	}
}
