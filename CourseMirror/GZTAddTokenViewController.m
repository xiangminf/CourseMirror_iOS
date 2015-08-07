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

@interface GZTAddTokenViewController (){
    UIView *view;
}

@end

@implementation GZTAddTokenViewController

-(void)viewWillLayoutSubviews{
    [view setFrame:CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"this is addtokenview controller");
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AddTokenView" owner:self options:nil];
    AddToken *tokenView = [nib objectAtIndex:0];

    
    [tokenView.addButton addTarget:self
               action:@selector(addMethod:)
     forControlEvents:UIControlEventTouchUpInside];
    
    view = tokenView;
    [self.view addSubview:view];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)addMethod{
    PFUser *currentUser = [PFUser currentUser];
    
    NSString *myToken = _tokenText.text;
    myToken = [myToken lowercaseString];
    
    BOOL valid = [GZTUtilities isString:myToken ofRegexPattern:@"[a-z][0-9][0-9][0-9][0-9]"];
    BOOL existing = [[[LibraryAPI sharedInstance] allTokens] containsObject:myToken];
    
    if(valid && existing){
        [[LibraryAPI sharedInstance] addToken:myToken forUser:currentUser];
        _tokenText.text = @"";
        
        [[[UIAlertView alloc] initWithTitle:@"Token Added" message:@"Go to Courses and pull down to refresh!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Done", nil] show];
        
    }else{
         [[[UIAlertView alloc] initWithTitle:@"Invalid or non-existing token" message:@"Please input a valid token, e.g: a1234" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Done", nil] show];
    }
    
    
    
}

@end
