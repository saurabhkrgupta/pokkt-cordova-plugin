//
//  PokktManager1.h
//  PokktManager
//
//  Created by Pokkt on 5/19/15.
//  Copyright (c) 2015 Pokkt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PokktConfig.h"
#import "PokktController.h"

@interface PokktManager : NSObject

+ (NSString*) getSDKVersion;

+ (void) initPokkt:(PokktConfig *)pokktConfig;

+ (void) setPokktDelegate:(id<PokktDelegate>)mDelegate;

+ (void) setPresentView:(UIViewController *)controller;

+ (void) setDebug:(BOOL)isDebug;

+ (void) startSession:(PokktConfig *)pokktConfig;

+ (void) endSession;

+ (float) getVideoVc;

+ (BOOL) isVideoAvailable;

+ (void) cacheVideoCampaign:(PokktConfig *)pokktConfig;

+ (void) playVideoCampaign:(PokktConfig *)pokktConfig;

@end
