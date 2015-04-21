//
//  JiraSettingsManager.h
//  Jira
//
//  Created by Bhupendra Singh on 4/21/15.
//  Copyright (c) 2015 Bhupendra Singh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JiraCommon.h"

@interface JiraSettingsManager : NSObject

+ (instancetype)sharedInstance;

+ (BOOL)isLoggedIn;

+ (void)confirmHostUrl:(NSString *)hostUrl username:(NSString *)username password:(NSString *)password completionBlock:(JiraCommonCompletionBlock)completionBlock;

@end
