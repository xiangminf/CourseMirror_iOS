//
//  GZTLectureCell.h
//  CourseMirror
//
//  Created by 童罡正 on 8/2/15.
//  Copyright (c) 2015 Gangzheng Tong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GZTLectureCell : UITableViewCell
@property(nonatomic, weak) IBOutlet UILabel *title;

@property(nonatomic, weak) IBOutlet UILabel *number;
@property(nonatomic, weak) IBOutlet UILabel *date;
@property(nonatomic, weak) IBOutlet UIImageView *status;
@end
