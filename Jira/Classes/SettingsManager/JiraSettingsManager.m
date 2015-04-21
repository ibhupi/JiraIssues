//
//  JiraSettingsManager.m
//  Jira
//
//  Created by Bhupendra Singh on 4/21/15.
//  Copyright (c) 2015 Bhupendra Singh. All rights reserved.
//

#import "JiraSettingsManager.h"

@interface JiraSettingsManager ()

@property (nonatomic) NSString *host;
@property (nonatomic) NSString *username;
@property (nonatomic) NSString *password;

@property (nonatomic, readonly) BOOL isLoggedIn;

@end

@implementation JiraSettingsManager

#pragma mark - Lifecycle

+ (instancetype)sharedInstance
{
    static id sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self new];
    });
    return sharedInstance;
}

#pragma mark - Custom Getter Setter

- (BOOL)isLoggedIn
{
    return self.username.length && self.password.length && self.host.length;
}


#pragma mark - Public Interfaces

+ (BOOL)isLoggedIn
{
    return [[self sharedInstance] isLoggedIn];
}

+ (void)confirmHostUrl:(NSString *)hostUrl
              username:(NSString *)username
              password:(NSString *)password
       completionBlock:(JiraCommonCompletionBlock)completionBlock
{
    [[self sharedInstance] _confirmHostUrl:hostUrl
                                  username:username
                                  password:password
                           completionBlock:completionBlock];
}

#pragma mark - Private Methods

- (void)_confirmHostUrl:(NSString *)hostUrl
               username:(NSString *)username
               password:(NSString *)password
        completionBlock:(JiraCommonCompletionBlock)completionBlock
{
    self.host = hostUrl;
    self.username = username;
    self.password = password;
    if (completionBlock)
    {
        completionBlock(YES, nil);
    }
}

#pragma mark - IBOutlet Events


#pragma mark - Delegates









@end
