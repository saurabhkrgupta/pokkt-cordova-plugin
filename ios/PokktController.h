//
//  PokktController.h
//  PokktManager
//
//  Created by Pokkt on 3/9/15.
//  Copyright (c) 2015 Pokkt. All rights reserved.
//

#import <UIKit/UIKit.h>


@class VideoResponse;

@protocol PokktDelegate <NSObject>
- (void)didFinishedVideoDownload:(BOOL)isFinished;
- (void)didFailedVideoDownload:(NSString *)errorMsg;
- (void)onVideoCompleated:(BOOL)isCompleated;
- (void)onVideoDisplayed ;
- (void)onVideoGratified:(VideoResponse *)videoResponse;
- (void)onVideoSkiped;
- (void)onVideoClosed;
@end

@interface PokktController : UIViewController <PokktDelegate>

@property (nonatomic, weak) id<PokktDelegate> pokktDelegate;


@end
