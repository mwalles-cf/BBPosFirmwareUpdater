//
//  ContentView.swift
//  BBPos Firmware Updater
//
//  Created by Micah A. Walles on 9/29/21.
//

import SwiftUI

struct ContentView: View {
	@State private var readers = [Reader]()

	var body: some View {
		VStack {
			HStack {
				Spacer()
				Button("Scan") {
					ReaderManager.scan { readers in
						self.readers = readers
					}
					//let readers = [
					//	Reader(name: "Reader1", firmwareRevision: "1.2.3", serialNumber: "XXXXXXX1"),
					//	Reader(name: "Reader2", firmwareRevision: "1.2.2", serialNumber: "XXXXXXX2"),
					//]
					//self.readers = readers
				}
			}
			ScrollView {
				ForEach(readers, id: \.self) { reader in
					HStack {
						VStack(alignment: .leading) {
							Text(reader.name).font(.subheadline)
//							HStack {
//								Text(reader.serialNumber).font(.footnote)
//								Text(reader.firmwareRevision).font(.footnote)
//							}
						}
						Spacer()
						Button("Connect") {
							ReaderManager.connect(peripheral: reader.peripheral) { deviceInfo in
								print(deviceInfo)
							}
						}
					}.padding()
				}
			}
		}.padding()
		Spacer()
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
