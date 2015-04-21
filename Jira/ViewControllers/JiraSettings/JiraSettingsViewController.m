//
//  JiraSettingsViewController.m
//  Jira
//
//  Created by Bhupendra Singh on 4/21/15.
//  Copyright (c) 2015 Bhupendra Singh. All rights reserved.
//

#import "JiraSettingsViewController.h"
#import "JiraSettingsManager.h"
#import "MBProgressHUD.h"

@interface JiraSettingsViewController ()

@property (nonatomic, copy) JiraCommonCompletionBlock completionBlock;

@property (strong, nonatomic) IBOutlet UITextField *hostUrlTextView;
@property (strong, nonatomic) IBOutlet UITextField *userNameTextView;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *closeButton;
@property (strong, nonatomic) IBOutlet UIButton *confirmButton;

- (IBAction)confirmButtonTapped:(id)sender;
- (IBAction)closeButtonTapped:(id)sender;

@end

@implementation JiraSettingsViewController

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.confirmButton.enabled = NO;
    self.title = @"Login";
    
    [self.hostUrlTextView addTarget:self action:@selector(_textFieldChange) forControlEvents:UIControlEventEditingChanged];
    [self.userNameTextView addTarget:self action:@selector(_textFieldChange) forControlEvents:UIControlEventEditingChanged];
    [self.passwordTextView addTarget:self action:@selector(_textFieldChange) forControlEvents:UIControlEventEditingChanged];
}

#pragma mark - Custom Getter Setter


#pragma mark - Public Interfaces

+ (NSString *)viewControllerIdentifier
{
    return @"JiraSettingsViewController";
}

+ (void)presentLoginViewFromViewController:(UIViewController *)presentingViewController completionBlock:(JiraCommonCompletionBlock)completionBlock
{
    if (!presentingViewController)
    {
        presentingViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    }
    
    JiraSettingsViewController *jiraSettingsViewController = [JiraSettingsViewController viewController];
    jiraSettingsViewController.completionBlock = completionBlock;
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:jiraSettingsViewController];
    
    [presentingViewController presentViewController:navigationController animated:YES completion:^{
    }];
}


#pragma mark - Private Methods

- (void)_textFieldChange
{
    BOOL confirmButtonEnabled = NO;
    if (self.hostUrlTextView.text.length &&
        self.userNameTextView.text.length &&
        self.passwordTextView.text.length)
    {
        confirmButtonEnabled = YES;
    }
    self.confirmButton.enabled = confirmButtonEnabled;
}


#pragma mark - IBOutlet Events

- (IBAction)confirmButtonTapped:(id)sender
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [JiraSettingsManager confirmHostUrl:self.hostUrlTextView.text username:self.userNameTextView.text password:self.passwordTextView.text completionBlock:^(BOOL success, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (!success)
        {
            return;
        }
        [self dismissViewControllerAnimated:YES completion:^{
            if (self.completionBlock)
            {
                self.completionBlock(success, error);
            }
        }];
    }];
}

- (IBAction)closeButtonTapped:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        if (self.completionBlock)
        {
            self.completionBlock(NO, nil);
        }
    }];
}


#pragma mark - Delegates


@end
