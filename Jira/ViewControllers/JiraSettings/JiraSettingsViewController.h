//
//  JiraSettingsViewController.h
//  Jira
//
//  Created by Bhupendra Singh on 4/21/15.
//  Copyright (c) 2015 Bhupendra Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "JiraCommon.h"

@interface JiraSettingsViewController : BaseViewController

+ (void)presentLoginViewFromViewController:(UIViewController *)presentingViewController completionBlock:(JiraCommonCompletionBlock)completionBlock;

@end
