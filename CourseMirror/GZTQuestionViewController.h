//
//  GZTQuestionViewController.h
//  CourseMirror
//
//  Created by 童罡正 on 8/3/15.
//  Copyright (c) 2015 Gangzheng Tong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GZTQuestionViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong)UIButton *previous;
@property(nonatomic, strong)UIButton *next;
@property(nonatomic, strong)UIButton *submit;

@end
