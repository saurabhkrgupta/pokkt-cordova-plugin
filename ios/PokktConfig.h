//
//  PokktConfig.h
//  PokktManager
//
//  Created by Pokkt on 5/19/15.
//  Copyright (c) 2015 Pokkt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PokktConfig : NSObject

@property (nonatomic, strong) NSString * applicationId ;
@property (nonatomic, strong) NSString * securityKey ;
@property (nonatomic, strong) NSString * thirdPartyUserId ;
@property (nonatomic)         BOOL       autoCacheVideo ;

// video campaign specific
@property (nonatomic, strong) NSString *  screenName ;
@property (nonatomic)         BOOL        skipEnabled ;
@property (nonatomic)         int         defaultSkipTime ;
@property (nonatomic, strong) NSString *  customSkipMessage ;
@property (nonatomic)         BOOL        incentivised ;

// optional parameters
@property (nonatomic, strong) NSString * name ;
@property (nonatomic, strong) NSString * age ;
@property (nonatomic, strong) NSString * sex ;
@property (nonatomic, strong) NSString * mobileNo ;
@property (nonatomic, strong) NSString * emailAddress ;
@property (nonatomic, strong) NSString * location ;
@property (nonatomic, strong) NSString * birthday ;
@property (nonatomic, strong) NSString * maritalStatus ;
@property (nonatomic, strong) NSString * facebookId ;
@property (nonatomic, strong) NSString * twitterHandle ;
@property (nonatomic, strong) NSString * education ;
@property (nonatomic, strong) NSString * nationality ;
@property (nonatomic, strong) NSString * employment ;
@property (nonatomic, strong) NSString * maturityRating ;


@end
