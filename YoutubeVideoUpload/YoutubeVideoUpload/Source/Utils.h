//
//  Utils.h
//  YouTube Direct Lite for iOS
//
//  Created by Ibrahim Ulukaya on 11/6/13.
//  Copyright (c) 2013 Google. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

static NSString *const DEFAULT_KEYWORD = @"ytdl";
static NSString *const UPLOAD_PLAYLIST = @"Replace me with the playlist ID you want to upload into";

//static NSString *const kClientID = @"498942286713-p2i4i2lfuckji5li6gkaokmjpt9eaamt.apps.googleusercontent.com";
//static NSString *const kClientSecret = @"HyvkZKmtS-ZdDoWhu0gX8Epo";


static NSString *const kClientID = @"44803061676-gb1oiivjsgtmgq3uvqn9ffpil5o9hh5o.apps.googleusercontent.com";
static NSString *const kClientSecret = @"TNkDqCHeORQDQ7av5ChM6itR";

static NSString *const kKeychainItemName = @"YouTubeSample: YouTube";

@interface Utils : NSObject

+ (UIAlertView*)showWaitIndicator:(NSString *)title;
+ (void)showAlert:(NSString *)title message:(NSString *)message;
+ (NSString *)humanReadableFromYouTubeTime:(NSString *)youTubeTimeFormat;

@end
