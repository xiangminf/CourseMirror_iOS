
//
//  Lecture.m
//  CourseMirror
//
//  Created by 童罡正 on 7/31/15.
//  Copyright (c) 2015 Gangzheng Tong. All rights reserved.
//

#import "Lecture.h"

@implementation Lecture

-(id)initWithCid:(NSString*)cid Title:(NSString*)title date: (NSString *)date number:(id)number questions: (NSArray *)questions{
    self = [super init];
    if(self){
        _cid = cid;
        _Title = title;
        _number = number;
        _questions = questions;
        //create date object
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM-dd-yyyy"];
        NSDate *lectureDate = [dateFormatter dateFromString:date];
        _date = lectureDate;
    }
    return self;
    
}

@end
