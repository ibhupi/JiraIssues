//
//  BaseViewController.m
//  Jira
//
//  Created by Bhupendra Singh on 4/21/15.
//  Copyright (c) 2015 Bhupendra Singh. All rights reserved.
//

#import "BaseViewController.h"
#import "JiraSettingsManager.h"
#import "JiraSettingsViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

#pragma mark - Lifecycle

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ([self requiresLoggedIn] &&
        ![JiraSettingsManager isLoggedIn])
    {
        [JiraSettingsViewController presentLoginViewFromViewController:self completionBlock:^(BOOL success, NSError *error) {
            if (success)
            {
                
            }
            else
            {
                
            }
        }];
    }
}

#pragma mark - Custom Getter Setter

#pragma mark - Public Interfaces

+ (instancetype)viewController
{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    if (!storyBoard)
    {
        return nil;
    }
    NSString *identifier = [self viewControllerIdentifier];
    if (!identifier.length)
    {
        return nil;
    }
    return [storyBoard instantiateViewControllerWithIdentifier:identifier];
}

+ (NSString *)viewControllerIdentifier
{
    return nil;
}

- (BOOL)requiresLoggedIn
{
    return NO;
}

#pragma mark - Private Methods

#pragma mark - IBOutlet Events

#pragma mark - Delegates



@end
