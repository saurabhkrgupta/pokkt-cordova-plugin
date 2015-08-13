#include <string>
#import <Foundation/Foundation.h>
#import <Cordova/CDV.h>
#import "PokktManager.h"
#import "PokktController.h"
#import "VideoResponse.h"
#import "PokktConfig.h"


// events
#define VideoDisplayedEvent             "VideoDisplayed"
#define VideoSkippedEvent               "VideoSkipped"
#define VideoClosedEvent                "VideoClosed"
#define VideoCompletedEvent             "VideoCompleted"
#define VideoGratifiedEvent             "VideoGratified"
#define DownloadCompletedEvent          "DownloadCompleted"
#define DownloadFailedEvent             "DownloadFailed"


CDVPlugin *cordovaPlugin = nil;

@interface PokktCordovaDelegate:NSObject<PokktDelegate>
@end


// --------------------------- CORDOVA ------------------------------

@interface PokktNativeExtension : CDVPlugin {
    PokktConfig *pokktConfig;
}

- (void) pluginInitialize;
- (bool) syncPokktConfig: (CDVInvokedUrlCommand*)command;
- (void) executeSuccessCallback: (CDVInvokedUrlCommand*)command;
- (void) executeErrorCallback: (CDVInvokedUrlCommand*)command;

- (void) setDebug: (CDVInvokedUrlCommand*)command;
- (void) showLog: (CDVInvokedUrlCommand*)command;
- (void) showToast: (CDVInvokedUrlCommand*)command;
- (void) initPokkt: (CDVInvokedUrlCommand*)command;
- (void) isVideoAvailable: (CDVInvokedUrlCommand*)command;
- (void) getVideoVc: (CDVInvokedUrlCommand*)command;
- (void) getPokktSDKVersion: (CDVInvokedUrlCommand*)command;

- (void) startSession: (CDVInvokedUrlCommand*)command;
- (void) endSession: (CDVInvokedUrlCommand*)command;

- (void) getCoins: (CDVInvokedUrlCommand*)command;
- (void) getPendingCoins: (CDVInvokedUrlCommand*)command;
- (void) checkOfferWallCampaign: (CDVInvokedUrlCommand*)command;

- (void) getVideo: (CDVInvokedUrlCommand*)command;
- (void) cacheVideoCampaign: (CDVInvokedUrlCommand*)command;

@end


@implementation PokktNativeExtension : CDVPlugin

- (void) pluginInitialize
{
    NSLog(@"pokkt plugin initialized!");
    
    [super pluginInitialize];
    
    pokktConfig = [[PokktConfig alloc] init];
    
    // set cordova plugin
    cordovaPlugin = self;
}

- (bool) syncPokktConfig: (CDVInvokedUrlCommand*)command;
{
    try
    {
        if (command.arguments.count > 0)
        {
            NSDictionary *config = [command.arguments objectAtIndex:0];
            
            if(config[@"securityKey"] != nil && ![config[@"securityKey"] isEqual:@""])
                pokktConfig.securityKey = config[@"securityKey"];
            
            if(config[@"applicationId"] != nil && ![config[@"applicationId"] isEqual:@""])
                pokktConfig.applicationId = config[@"applicationId"];
            
            //pokktConfig.integrationType = config[@"integrationType"];
            pokktConfig.autoCacheVideo = [config[@"autoCaching"] boolValue];
            
            if(config[@"screenName"] != nil && ![config[@"screenName"] isEqual:@""])
                pokktConfig.screenName = config[@"screenName"];
            
            //pokktConfig.offerwallAssetValue = config[@"offerwallAssetValue"];
            pokktConfig.incentivised = [config[@"incentivised"] boolValue];
            
            if(config[@"thirdPartyUserId"] != nil && ![config[@"thirdPartyUserId"] isEqual:@""])
                pokktConfig.thirdPartyUserId = config[@"thirdPartyUserId"];
            
            //pokktConfig.closeOnSuccessFlag = config[@"closeOnSuccessFlag"];
            pokktConfig.skipEnabled = [config[@"skipEnabled"] boolValue];
            pokktConfig.defaultSkipTime = [config[@"defaultSkipTime"] intValue];
            pokktConfig.customSkipMessage = config[@"customSkipMessage"];
            //pokktConfig.backButtonDisabled = config[@"backButtonDisabled"];
            
            if(config[@"name"] != nil && ![config[@"name"] isEqual:@""])
                pokktConfig.name = config[@"name"];
            
            if(config[@"age"] != nil && ![config[@"age"] isEqual:@""])
                pokktConfig.age = config[@"age"];
            
            if(config[@"sex"] != nil && ![config[@"sex"] isEqual:@""])
                pokktConfig.sex = config[@"sex"];
            
            if(config[@"mobileNo"] != nil && ![config[@"mobileNo"] isEqual:@""])
                pokktConfig.mobileNo = config[@"mobileNo"];
            
            if(config[@""] != nil && ![config[@"emailAddress"] isEqual:@""])
                pokktConfig.emailAddress = config[@"emailAddress"];
            
            if(config[@"emailAddress"] != nil && ![config[@"location"] isEqual:@""])
                pokktConfig.location = config[@"location"];
            
            if(config[@"birthday"] != nil && ![config[@"birthday"] isEqual:@""])
                pokktConfig.birthday = config[@"birthday"];
            
            if(config[@"maritalStatus"] != nil && ![config[@"maritalStatus"] isEqual:@""])
                pokktConfig.maritalStatus = config[@"maritalStatus"];
            
            if(config[@"facebookId"] != nil && ![config[@"facebookId"] isEqual:@""])
                pokktConfig.facebookId = config[@"facebookId"];
            
            if(config[@"twitterHandle"] != nil && ![config[@"twitterHandle"] isEqual:@""])
                pokktConfig.twitterHandle = config[@"twitterHandle"];
            
            if(config[@"education"] != nil && ![config[@"education"] isEqual:@""])
                pokktConfig.education = config[@"education"];
            
            if(config[@"nationality"] != nil && ![config[@"nationality"] isEqual:@""])
                pokktConfig.nationality = config[@"nationality"];
            
            if(config[@"employment"] != nil && ![config[@"employment"] isEqual:@""])
                pokktConfig.employment = config[@"employment"];
            
            if(config[@"maturityRating"] != nil && ![config[@"maturityRating"] isEqual:@""])
                pokktConfig.maturityRating = config[@"maturityRating"];
            
            return true;
        }
    }
    catch (NSException *e)
    {
        NSLog(@"invalid pokkt config provided! : %@", e.reason);
    }
    
    return false;
}

- (void) executeSuccessCallback: (CDVInvokedUrlCommand*)command;
{
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) executeErrorCallback: (CDVInvokedUrlCommand*)command
{
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}


// ------- POKKT SDK STATES/OPERATIONS -------

- (void) setDebug: (CDVInvokedUrlCommand*)command
{
    try
    {
        if (command.arguments.count > 0)
        {
            NSDictionary *config = [command.arguments objectAtIndex:0];
            bool isDebug = [config[@"param"] boolValue];
            [PokktManager setDebug:isDebug];
            
            [self executeSuccessCallback:command];
        }
    }
    catch (NSException *e)
    {
        NSLog(@"invalid param received! : %@", e.reason);
    }
}

- (void) showLog: (CDVInvokedUrlCommand*)command
{
    NSLog(@"showLog is not supported by the iOS Plugin.");
    
    [self executeErrorCallback:command];
}

- (void) showToast: (CDVInvokedUrlCommand*)command
{
    NSLog(@"showToast is not supported by the iOS Plugin.");
    
    [self executeErrorCallback:command];
}

- (void) initPokkt:(CDVInvokedUrlCommand *)command
{
    if ([self syncPokktConfig:command])
    {
        [PokktManager initPokkt:pokktConfig];
        
        PokktCordovaDelegate *delegate = [[PokktCordovaDelegate alloc] init];
        [PokktManager setPokktDelegate:delegate];
        
        [self executeSuccessCallback:command];
    }
    else
    {
        [self executeErrorCallback:command];
    }
}

- (void) isVideoAvailable: (CDVInvokedUrlCommand*)command
{
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    BOOL value = [PokktManager isVideoAvailable];
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:value];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) getVideoVc: (CDVInvokedUrlCommand*)command
{
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    float value = [PokktManager getVideoVc];
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDouble:value];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) getPokktSDKVersion: (CDVInvokedUrlCommand*)command
{
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    NSString *result = [PokktManager getSDKVersion];
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:result];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}


// ------- POKKT SESSION OPERATIONS -------

- (void) startSession: (CDVInvokedUrlCommand*)command
{
    if ([self syncPokktConfig:command])
    {
        [PokktManager startSession:pokktConfig];
        
        [self executeSuccessCallback:command];
    }
    else
    {
        [self executeErrorCallback:command];
    }
}

- (void) endSession: (CDVInvokedUrlCommand*)command
{
    if ([self syncPokktConfig:command])
    {
        [PokktManager endSession];
        
        [self executeSuccessCallback:command];
    }
    else
    {
        [self executeErrorCallback:command];
    }
}


// ------- POKKT OFFERWALL OPERATIONS -------

// OfferWall Methods -- NOT Supported in iOS Plugin -- should log case.

- (void) getCoins: (CDVInvokedUrlCommand*)command
{
    NSLog(@"getCoins is not supported by the iOS Plugin.");
    
    [self executeErrorCallback:command];
}

- (void) getPendingCoins: (CDVInvokedUrlCommand*)command
{
    NSLog(@"getPendignCoins is not supported by the iOS Plugin.");
    
    [self executeErrorCallback:command];
}

- (void) checkOfferWallCampaign: (CDVInvokedUrlCommand*)command
{
    NSLog(@"checkOfferWallCampaign is not supported by the iOS Plugin.");
    
    [self executeErrorCallback:command];
}


// ------- POKKT VIDEO OPERATIONS -------

- (void) getVideo: (CDVInvokedUrlCommand*)command
{
    if ([self syncPokktConfig:command])
    {
        // set the view controller
        UIViewController *viewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
        [PokktManager setPresentView:viewController];
        
        [PokktManager playVideoCampaign:pokktConfig];
        
        [self executeSuccessCallback:command];
    }
    else
    {
        [self executeErrorCallback:command];
    }
}

- (void) cacheVideoCampaign: (CDVInvokedUrlCommand*)command
{
    if ([self syncPokktConfig:command])
    {
        [PokktManager cacheVideoCampaign:pokktConfig];
        
        [self executeSuccessCallback:command];
    }
    else
    {
        [self executeErrorCallback:command];
    }
}

@end

// use this to notify the cordova observer
static void NotifyCordova(NSString* operation, NSString*  param)
{
    if (cordovaPlugin != nil)
    {
        NSString *event = [NSString stringWithFormat:@"javascript:cordova.fireDocumentEvent('%@', { 'param': '%@' });", operation, param];
        [[cordovaPlugin webView] stringByEvaluatingJavaScriptFromString:event];
    }
    else
    {
        NSLog(@"plugin not found!");
    }
}


// ----------------------- DELEGATES ------------------------------

@implementation PokktCordovaDelegate

#pragma mark - Pokkt Delegates

- (void)didFinishedVideoDownload:(BOOL)isFinished
{
    float vc = [PokktManager getVideoVc];
    NotifyCordova(@DownloadCompletedEvent, [[NSNumber numberWithFloat:vc] stringValue]);
}

- (void)didFailedVideoDownload:(NSString *)error
{
    NotifyCordova(@DownloadFailedEvent, error);
}

- (void)onVideoCompleated:(BOOL)isCompleated
{
    NotifyCordova(@VideoCompletedEvent, @"Video is completed");
}

- (void)onVideoDisplayed
{
    NotifyCordova(@VideoDisplayedEvent, @"Video is displayed");
}

- (void)onVideoClosed
{
    NotifyCordova(@VideoClosedEvent, @"Video is closed");
}

- (void)onVideoGratified:(VideoResponse *)videoResponse
{
    NotifyCordova(@VideoGratifiedEvent, videoResponse.coins);
}

- (void)onVideoSkiped
{
    NotifyCordova(@VideoSkippedEvent, @"Video is skipped");
}

@end
