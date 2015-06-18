//
//  ViewController.m
//  Lleida.net
//
//  Created by Joan Martin on 18/06/15.
//  Copyright (c) 2015 Mobile Jazz. All rights reserved.
//

#import "ViewController.h"
#import "MJLleidaNetClient.h"
#import <MBProgressHUD/MBProgressHUD.h>

typedef NS_ENUM(NSUInteger, Section)
{
    SectionConfiguration,
    SectionActions,
};

typedef NS_ENUM(NSUInteger, ActionRow)
{
    ActionRowUserDetails,
    ActionRowSendSMS,
};

typedef NS_ENUM(NSUInteger, TextFieldType)
{
    TextFieldTypeUnknown,
    TextFieldTypeUsername,
    TextFieldTypePassword,
    TextFieldTypeNumber,
    TextFieldTypeSMS,
};

static NSString * const kUsernameKey = @"com.mobilejazz.Lleida-net.username";
static NSString * const kPasswordKey = @"com.mobilejazz.Lleida-net.password";

@interface ViewController () <UITextFieldDelegate>

@end

@implementation ViewController
{
    MJLleidaNetClient *_client;
    
    __weak IBOutlet UITextField *_usernameField;
    __weak IBOutlet UITextField *_passwordField;
    
    
    __block UITextField *_numberField;
    __block UITextField *_messageField;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _usernameField.tag = TextFieldTypeUsername;
    _passwordField.tag = TextFieldTypePassword;
    
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:kUsernameKey];
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:kPasswordKey];
    _usernameField.text = username;
    _passwordField.text = password;
    
    if (username && password)
        _client = [[MJLleidaNetClient alloc] initWithUsername:username password:password];
}

#pragma mark Private Methods

- (void)mjz_showAlertWithTitle:(NSString*)title message:(NSString*)message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)mjz_sendSMS
{
    NSString *phone = _numberField.text;
    NSString *message = _messageField.text;
    
    if (phone.length == 0 || message.length == 0)
    {
        [self mjz_showAlertWithTitle:@"Failed" message:@"Phone or message were empty. Any SMS has not been sent."];
    }
    else
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [_client api_sendSMS:message phones:@[phone] completionBlock:^(MJLleidaNetResult *result, NSError *error) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            
            if (error)
                [self mjz_showAlertWithTitle:@"Error" message:error.localizedDescription];
            else
                [self mjz_showAlertWithTitle:@"Result" message:result.description];
        }];
    }
    
}

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _usernameField)
    {
        if (_usernameField.text.length == 0)
            [self mjz_showAlertWithTitle:@"Invalid Username" message:@"Please, enter a valid username."];
        else
        {
            NSString *username = _usernameField.text;
            [[NSUserDefaults standardUserDefaults] setObject:username forKey:kUsernameKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [_passwordField becomeFirstResponder];
        }
    }
    else if (textField == _passwordField)
    {
        if (_passwordField.text.length == 0)
            [self mjz_showAlertWithTitle:@"Invalid Password" message:@"Please, enter a valid password."];
        else
        {
            NSString *password = _passwordField.text;
            [[NSUserDefaults standardUserDefaults] setObject:password forKey:kPasswordKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            _client = [[MJLleidaNetClient alloc] initWithUsername:_usernameField.text password:_passwordField.text];
            [_passwordField resignFirstResponder];
        }
    }
    else if (textField == _numberField)
    {
        [_messageField becomeFirstResponder];
    }
    else if (textField == _messageField)
    {
        [self.presentedViewController dismissViewControllerAnimated:YES completion:^{
            [self mjz_sendSMS];
            [_messageField resignFirstResponder];
        }];
    }
    
    return NO;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    if (section == SectionActions)
    {
        if (_client == nil)
        {
            [self mjz_showAlertWithTitle:@"Warning" message:@"Please, enter a valid username and password."];
        }
        else
        {
            if (row == ActionRowUserDetails)
            {
                [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                [_client api_userDetailsWithCompletionBlock:^(MJLleidaNetResult *result, NSError *error) {
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                    
                    if (error)
                        [self mjz_showAlertWithTitle:@"Error" message:error.localizedDescription];
                    else
                        [self mjz_showAlertWithTitle:@"Result" message:result.description];
                }];
            }
            else if (row == ActionRowSendSMS)
            {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Send SMS" message:nil preferredStyle:UIAlertControllerStyleAlert];
                
                [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                    _numberField = textField;
                    textField.placeholder = @"Phone number";
                    textField.keyboardType = UIKeyboardTypePhonePad;
                    textField.delegate = self;
                    textField.tag = TextFieldTypeNumber;
                }];
                
                [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                    _messageField = textField;
                    textField.placeholder = @"Message";
                    textField.keyboardType = UIKeyboardTypeDefault;
                    textField.delegate = self;
                    textField.returnKeyType = UIReturnKeySend;
                    textField.tag = TextFieldTypePassword;
                }];
                
                [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                                                    style:UIAlertActionStyleCancel
                                                                  handler:^(UIAlertAction *action) {
                                                                      _numberField = nil;
                                                                      _messageField = nil;
                                                                  }]];
                
                [alertController addAction:[UIAlertAction actionWithTitle:@"Send"
                                                                    style:UIAlertActionStyleDestructive
                                                                  handler:^(UIAlertAction *action) {
                                                                      [self mjz_sendSMS];
                                                                      _numberField = nil;
                                                                      _messageField = nil;
                                                                  }]];
                
                [self presentViewController:alertController animated:YES completion:nil];
            }
        }
    }
}

@end
