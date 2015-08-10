//
//  GZTAddTokenViewController.m
//  CourseMirror
//
//  Created by 童罡正 on 8/5/15.
//  Copyright (c) 2015 Gangzheng Tong. All rights reserved.
//

#import "GZTAddTokenViewController.h"
#import "AddToken.h"
#import "ParseClient.h"
#import "GZTUtilities.h"
#import "LibraryAPI.h"
#import "GZTGlobalModule.h"

@interface GZTAddTokenViewController (){
    UIViewController *addTokenVC;
    NSArray *specialTokens;
}

@end

@implementation GZTAddTokenViewController


- (void)viewDidLoad {
    specialTokens = [[NSArray alloc] initWithObjects:@"t2015", @"t2014", nil];
    [super viewDidLoad];
    
    // HIDE keyboard
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}
-(void)dismissKeyboard {
    [self.textField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)addMethod:(id)sender {
    PFUser *currentUser = [PFUser currentUser];
    
    NSString *myToken = _textField.text;
    myToken = [myToken lowercaseString];
    
    
    
    
    BOOL valid = [GZTUtilities isString:myToken ofRegexPattern:@"[a-z][0-9][0-9][0-9][0-9]"];
    BOOL existing = [[[LibraryAPI sharedInstance] allTokens] containsObject:myToken];
    
    //notification enabled
    if([specialTokens containsObject:myToken]){
        [[GZTGlobalModule settingViewController].tableView reloadData];
    }
    
    if(valid && existing){
        [[LibraryAPI sharedInstance] addToken:myToken forUser:currentUser];
        _textField.text = @"";
        
        [[GZTGlobalModule courseViewController] refresh];
        
        [[[UIAlertView alloc] initWithTitle:@"Token Added" message:@"Go to Courses and pull down to refresh!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Done", nil] show];
        
    }else{
        [[[UIAlertView alloc] initWithTitle:@"Invalid or non-existing token" message:@"Please input a valid token, e.g: a1234" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Done", nil] show];
    }
    
    
}
- (IBAction)cancelMethod:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}
@end
