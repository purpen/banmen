//
//  THNDownloadFontTool.m
//  banmen
//
//  Created by FLYang on 2017/8/23.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNDownloadFontTool.h"
#import <CoreText/CoreText.h>

@implementation THNDownloadFontTool

+ (BOOL)thn_isDownloadedFont:(NSString *)fontName {
    UIFont *theFont = [UIFont fontWithName:fontName size:12];
    
    if (theFont && ([theFont.fontName compare:fontName] == NSOrderedSame || [theFont.familyName compare:fontName] == NSOrderedSame)) {
        return YES;
    } else {
        return NO;
    }
}

+ (void)thn_downLoadFontWithFontName:(NSString *)fontName progress:(void (^)(CGFloat))progress complete:(void (^)(void))complete errorMsg:(void (^)(NSString *))errorMsg {
    NSMutableDictionary *attrs = [NSMutableDictionary dictionaryWithObjectsAndKeys:fontName, kCTFontNameAttribute, nil];

    CTFontDescriptorRef desc = CTFontDescriptorCreateWithAttributes((__bridge CFDictionaryRef)attrs);

    NSMutableArray *descs = [NSMutableArray arrayWithCapacity:0];
    [descs addObject:(__bridge id)desc];
    CFRelease(desc);

    __block BOOL errorDuringDownload = NO;

    CTFontDescriptorMatchFontDescriptorsWithProgressHandler( (__bridge CFArrayRef)descs, NULL,  ^(CTFontDescriptorMatchingState state, CFDictionaryRef progressParameter) {

        double progressValue = [[(__bridge NSDictionary *)progressParameter objectForKey:(id)kCTFontDescriptorMatchingPercentage] doubleValue];

        if (state == kCTFontDescriptorMatchingDidBegin) {
            dispatch_async( dispatch_get_main_queue(), ^ {
                complete();

            });
        } else if (state == kCTFontDescriptorMatchingDidFinish) {
            dispatch_async( dispatch_get_main_queue(), ^ {
                complete();

                CTFontRef fontRef = CTFontCreateWithName((__bridge CFStringRef)fontName, 0., NULL);
                CFStringRef fontURL = CTFontCopyAttribute(fontRef, kCTFontURLAttribute);
                CFRelease(fontURL);
                CFRelease(fontRef);

                if (!errorDuringDownload) {
                    NSLog(@"%@ downloaded", fontName);
                }
            });

        } else if (state == kCTFontDescriptorMatchingWillBeginDownloading) {
            dispatch_async( dispatch_get_main_queue(), ^ {
                NSLog(@"Begin Downloading");
            });

        } else if (state == kCTFontDescriptorMatchingDidFinishDownloading) {
            dispatch_async( dispatch_get_main_queue(), ^ {
                NSLog(@"Finish downloading");
            });

        } else if (state == kCTFontDescriptorMatchingDownloading) {
            dispatch_async( dispatch_get_main_queue(), ^ {
                progress(progressValue);
            });

        } else if (state == kCTFontDescriptorMatchingDidFailWithError) {
            NSString *_errorMessage;
            NSError *error = [(__bridge NSDictionary *)progressParameter objectForKey:(id)kCTFontDescriptorMatchingError];
            if (error != nil) {
                _errorMessage = [error description];

            } else {
                _errorMessage = @"ERROR MESSAGE IS NOT AVAILABLE!";
            }

            errorDuringDownload = YES;

            dispatch_async( dispatch_get_main_queue(), ^ {
                errorMsg(_errorMessage);
            });
        }

        return (bool)YES;
    });
    
}

@end
