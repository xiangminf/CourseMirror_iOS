//
//  GZTGlobalModule.h
//  CourseMirror
//
//  Created by 童罡正 on 8/2/15.
//  Copyright (c) 2015 Gangzheng Tong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LibraryAPI.h"
#import "GZTSettingViewController.h"
#import "GZTCourseViewController.h"
#import "GZTLectureViewController.h"


@interface GZTGlobalModule : NSObject

+(void) setSelectedCid: (NSString *)cid;
+(NSString *)selectedCid;

+(NSArray *)allLectures;

+(void) setSelectedLecture: (Lecture *)cid;
+(Lecture *)selectedLecture;

+(void) setSettingViewController: (GZTSettingViewController *)vc;
+(GZTSettingViewController *) settingViewController;

+(void) setCourseViewController: (GZTCourseViewController *)vc;
+(GZTCourseViewController*) courseViewController;

+(void) setLectureViewController: (GZTLectureViewController *)vc;
+(GZTLectureViewController*) LectureViewController;

//+(void) activeToken: (NSString *)token;
+(NSString *)getActiveToken;

+(void) setSelectedCourse: (Course *)c;
+(Course *)selectedCourse;

@end
