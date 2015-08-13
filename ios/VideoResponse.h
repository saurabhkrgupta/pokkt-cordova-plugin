//
//  VideoResponse.h
//  PokktManager
//
//  Created by Pokkt on 3/9/15.
//  Copyright (c) 2015 Pokkt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoResponse : NSObject

@property (nonatomic, strong)NSString *coinStatus;
@property (nonatomic, strong)NSString *coins;
@property (nonatomic, strong)NSString *transactionId;
@property (nonatomic, strong)NSString *message;

@end
