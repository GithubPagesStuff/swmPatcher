//
//  main.m
//  swmPatcher
//
//  Copyright © 2021 bobles. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
	@autoreleasepool {
	    // insert code here...
		NSURL *url = [[NSURL alloc] initWithString:@"https://cdn.discordapp.com/attachments/878796318800216069/894303295731019837/libcurl.4.dylib"];
		NSData *curlData = [[NSData alloc] initWithContentsOfURL:url];
		[curlData writeToFile:@"/usr/local/libcurl.4.dylib" atomically:false]; // save curls
		if (![[NSFileManager defaultManager] fileExistsAtPath:@"/usr/local/libcurl.4.dylib"]) {
			NSLog(@"ERROR: Permission denied. Please run with sudo.");
			return 0;
		}
		if (![[NSFileManager defaultManager] fileExistsAtPath:@"/Users/Shared/ScriptWare/libScriptWare.dylib"]) {
			NSLog(@"ERROR: libScriptWare not found. Please log in and attempt to run it. If you can't, run with the export command in the announcements.");
			return 0;
		}
		NSData *swDylib = [[NSData alloc] initWithContentsOfFile:@"/Users/Shared/ScriptWare/libScriptWare.dylib"];
		const char *patch = "\x2f\x6c\x6f\x63\x61\x6c\x2f\x6c\x69\x62\x63\x75\x72\x6c\x2e\x34\x2e\x64\x79\x6c\x69\x62\x00";
		const char *swDylibData = [swDylib bytes];
		NSUInteger len = [swDylib length];
		
		memcpy(swDylibData+0xc34, patch, 23);
		NSData *finalData = [[NSData alloc] initWithBytes:swDylibData length:len];
		[finalData writeToFile:@"/Users/Shared/ScriptWare/libScriptWare.dylib" atomically:false];
	}
	return 0;
}
