//
//  Lecture.h
//  CourseMirror
//
//  Created by 童罡正 on 7/31/15.
//  Copyright (c) 2015 Gangzheng Tong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Lecture : NSObject
@property (nonatomic, copy, readonly) NSString *Title, *cid, *number;
@property (nonatomic, copy, readonly) NSDate *date;

-(id)initWithCid:(NSString*)cid Title:(NSString*)title date: (NSString *)date number:(NSString *)number;


@end
