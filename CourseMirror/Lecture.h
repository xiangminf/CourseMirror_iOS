//
//  Lecture.h
//  CourseMirror
//
//  Created by 童罡正 on 7/31/15.
//  Copyright (c) 2015 Gangzheng Tong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Lecture : NSObject
@property (nonatomic, copy, readonly) NSString *Title, *cid;
@property (nonatomic, copy, readonly) NSDate *date;
@property (nonatomic, copy, readonly) NSArray *questions;
@property (nonatomic, copy, readonly) id number;


-(id)initWithCid:(NSString*)cid Title:(NSString*)title date: (NSString *)date number:(id)number questions: (NSArray *)questions;


@end
