//
//  ContentView.swift
//  BBPos Firmware Updater
//
//  Created by Micah A. Walles on 9/29/21.
//

import SwiftUI

struct ContentView: View {
	@State private var readers = [Reader]()
	@State private var deviceInformation: DeviceInformation? = nil
	@State private var updating = false

	var body: some View {
		if let deviceInformation = self.deviceInformation {
			VStack(alignment: .leading) {
				HStack {
					Spacer()
					Button("Disconect") {
						ReaderManager.disconnect {
							self.deviceInformation = nil
						}
					}
				}
				VStack(alignment: .leading) {
					// `Group`s where added because an element in Swift UI can only have 10 elements at max
					Group {
						Text("bID: \(deviceInformation.bID)")
						Text("batteryLevel: \(deviceInformation.batteryLevel)")
						Text("batteryPercentage: \(deviceInformation.batteryPercentage)")
						Text("bootloaderVersion: \(deviceInformation.bootloaderVersion)")
						Text("deviceSettingVersion: \(deviceInformation.deviceSettingVersion)")
						Text("emvKsn: \(deviceInformation.emvKsn)")
						Text("firmwareVersion: \(deviceInformation.firmwareVersion)")
						Text("formatID: \(deviceInformation.formatID)")
						Text("hardwareVersion: \(deviceInformation.hardwareVersion)")
						Text("isCharging: \((deviceInformation.isCharging) ? "TRUE" : "FALSE")")
					}
					Group {
						Text("isSupportedNfc: \((deviceInformation.isSupportedNfc) ? "TRUE" : "FALSE")")
						Text("isSupportedSoftwarePinPad: \((deviceInformation.isSupportedSoftwarePinPad) ? "TRUE" : "FALSE")")
						Text("isSupportedTrack1: \((deviceInformation.isSupportedTrack1) ? "TRUE" : "FALSE")")
						Text("isSupportedTrack2: \((deviceInformation.isSupportedTrack2) ? "TRUE" : "FALSE")")
						Text("isSupportedTrack3: \((deviceInformation.isSupportedTrack3) ? "TRUE" : "FALSE")")
						Text("isUsbConnected: \((deviceInformation.isUsbConnected) ? "TRUE" : "FALSE")")
						Text("macKsn: \(deviceInformation.macKsn)")
						Text("pinKsn: \(deviceInformation.pinKsn)")
						Text("productID: \(deviceInformation.productID)")
						Text("sdkVersion: \(deviceInformation.sdkVersion)")
					}
					Group {
						Text("serialNumber: \(deviceInformation.serialNumber)")
						Text("terminalSettingVersion: \(deviceInformation.terminalSettingVersion)")
						Text("trackKsn: \(deviceInformation.trackKsn)")
						Text("uid: \(deviceInformation.uid)")
						Text("vendorID: \(deviceInformation.vendorID)")
					}
				}
				Divider()
				HStack {
					Button("Update Firmware") {
						ReaderManager.updateFirmware(to: deviceInformation.updateFirmwareVersion)
					}
					Text("Firmware will be update to verion \(deviceInformation.updateFirmwareVersion)")
				}
				Spacer()
			}.padding()
		} else {
			VStack {
				HStack {
					Spacer()
					Button("Scan") {
						ReaderManager.scan { readers in
							self.readers = readers
						}
					}
				}
				ScrollView {
					ForEach(readers, id: \.self) { reader in
						HStack {
							VStack(alignment: .leading) {
								Text(reader.name).font(.subheadline)
							}
							Spacer()
							Button("Connect") {
								ReaderManager.connect(peripheral: reader.peripheral) { deviceInfo in
									deviceInformation = deviceInfo
								}
							}
						}.padding()
					}
				}
			}.padding()
			Spacer()
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


class Reader: NSObject {
//	init(name: String, firmwareRevision: String, serialNumber: String) {
//		self.name = name
//		self.firmwareRevision = firmwareRevision
//		self.serialNumber = serialNumber
//	}

//	init(accessory: EAAccessory) {
//		name = accessory.name
//		firmwareRevision = accessory.firmwareRevision
//		serialNumber = accessory.serialNumber
//	}

	init(peripheral: CBPeripheral) {
		name = peripheral.name ?? "Unknown"
		self.peripheral = peripheral
	}

	let name: String
//	var firmwareRevision: String
//	var serialNumber: String
	let peripheral: CBPeripheral

	func connect() {

	}

}
