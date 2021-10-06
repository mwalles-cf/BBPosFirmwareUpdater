//
//  ReaderScanner.m
//  BBPos Firmware Updater
//
//  Created by Micah A. Walles on 10/1/21.
//

#import <Foundation/Foundation.h>
#import "ReaderScanner.h"
#import "BBDeviceController.h"
#import "BBPosFirmwareUpdater-Swift.h"

@implementation ReaderScanner: NSObject

-(instancetype _Nonnull) initWithCompletionHandler: (void(^_Nonnull)(NSArray<Reader*>* _Nonnull))completionHandler {
	self = [super init];
	_completionHandler = completionHandler;

	return self;
}

-(void) scan {
	[[BBDeviceController sharedController] setDelegate:self];
	[[BBDeviceController sharedController] startBTScan:nil scanTimeout:6000];
}

#pragma mark - BBDeviceControllerDelegate
- (void)onBTScanTimeout {
	NSLog(@"%s", __PRETTY_FUNCTION__);
}
- (void)onBTScanStopped {
	NSLog(@"%s", __PRETTY_FUNCTION__);
}
- (void)onBTReturnScanResults:(NSArray *)devices {
	NSLog(@"%s", __PRETTY_FUNCTION__);
}
- (void)onBTConnected:(NSObject *)connectedDevice {
	NSLog(@"%s", __PRETTY_FUNCTION__);
}
- (void)onBTDisconnected {
	NSLog(@"%s", __PRETTY_FUNCTION__);
}
- (void)readRSSI {
	NSLog(@"%s", __PRETTY_FUNCTION__);
}
- (void)stopReadRSSI {
	NSLog(@"%s", __PRETTY_FUNCTION__);
}
- (void)onBTReturnReadRSSIResult:(BBDeviceReadRSSIResult)result RSSI:(NSNumber *)RSSI message:(NSString *)message {
	NSLog(@"%s", __PRETTY_FUNCTION__);
}
- (void)onRequestEnableBluetoothInSettings {
	NSLog(@"%s", __PRETTY_FUNCTION__);
}
- (void)onBTRequestPairing {
	NSLog(@"%s", __PRETTY_FUNCTION__);
}
- (void)connectBT:(NSObject *)device {
	NSLog(@"%s", __PRETTY_FUNCTION__);
}
- (void)connectBTWithUUID:(NSString *)UUID {
	NSLog(@"%s", __PRETTY_FUNCTION__);
}

@end
