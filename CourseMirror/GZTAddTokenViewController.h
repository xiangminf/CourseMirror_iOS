//
//  GZTAddTokenViewController.h
//  CourseMirror
//
//  Created by 童罡正 on 8/5/15.
//  Copyright (c) 2015 Gangzheng Tong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GZTAddTokenViewController : UIViewController
- (IBAction)sync:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *textField;
- (IBAction)addMethod:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *addButton;

@property (weak, nonatomic) IBOutlet UIButton *cancel;
- (IBAction)cancelMethod:(id)sender;

@end
