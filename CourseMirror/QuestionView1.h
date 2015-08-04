//
//  QuestionView1.h
//  CourseMirror
//
//  Created by 童罡正 on 8/3/15.
//  Copyright (c) 2015 Gangzheng Tong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionView1 : UIView
@property(nonatomic, weak) IBOutlet UILabel *question;

@property(nonatomic, weak) IBOutlet UITableView *options;
@property(nonatomic, weak) IBOutlet UIButton *previous;
@property(nonatomic, weak) IBOutlet UIButton *next;
@end
