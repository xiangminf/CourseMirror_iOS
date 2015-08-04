//
//  LibraryAPI.h
//  CourseMirror
//
//  Created by 童罡正 on 7/31/15.
//  Copyright (c) 2015 Gangzheng Tong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Course.h"
#import "Lecture.h"

@interface LibraryAPI : NSObject
+(LibraryAPI *)sharedInstance;
-(NSArray *)getCourses;
-(NSArray *)getLectures;
-(NSArray *)getLecturesForCid: (NSString *)cid;

-(NSArray *)getQuestions;

@end