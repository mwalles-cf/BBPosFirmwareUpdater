//
//  DeviceInformation.swift
//  BBPosFirmwareUpdater
//
//  Created by Micah A. Walles on 10/7/21.
//

import Foundation

struct DeviceInformation {
	let bID: String // = CHB202931007235;
	let batteryLevel: String // = "3.962";
	let batteryPercentage: String // = 79;
	let bootloaderVersion: String // = "5.00.16.21";
	let deviceSettingVersion: String // = "CFZZ_Generic_v42";
	let emvKsn: String // = 00260631912338200067;
	let firmwareVersion: String // = "1.00.02.24";
	let formatID: String // = 60;
	let hardwareVersion: String // = "1.0.5";
	let isCharging: Bool // = 0;
	let isSupportedNfc: Bool // = 1;
	let isSupportedSoftwarePinPad: Bool // = 0;
	let isSupportedTrack1: Bool // = 1;
	let isSupportedTrack2: Bool // = 1;
	let isSupportedTrack3: Bool // = 0;
	let isUsbConnected: Bool // = 0;
	let macKsn: String // = 00260631912338600001;
	let pinKsn: String // = 00260631912338000004;
	let productID: String // = 4348423230;
	let sdkVersion: String // = "3.19.1";
	let serialNumber: String // = CHB202931007235;
	let terminalSettingVersion: String // = "CFZZ_Generic_v42";
	let trackKsn: String // = 0026063191233840006B;
	let uid: String // = 3500290012504D3256333420;
	let vendorID: String // = 43465A5A;

	var updateFirmwareVersion: String {
		let model = RederModel(serial: bID)
		return model.updateVersion(for: firmwareVersion)
	}
}
