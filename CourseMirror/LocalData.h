//
//  LocalData.h
//  CourseMirror
//
//  Created by 童罡正 on 8/2/15.
//  Copyright (c) 2015 Gangzheng Tong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Course.h"

@interface LocalData : NSObject
@property(nonatomic, copy, readonly) NSArray *alllectures;
@property(nonatomic, copy, readonly) NSArray *allquestions;


- (NSArray *) getCourses;
- (NSArray *) getLectures;
-(NSArray *)getLecturesForCid: (NSString *)cid;

-(NSArray *)getQuestions;


- (NSArray *) getCoursesForToken: (NSString *) token;
- (NSArray *) getCoursesForcid: (NSString *) cid;



@end
