
//
//  GZTGlobalModule.m
//  CourseMirror
//
//  Created by 童罡正 on 8/2/15.
//  Copyright (c) 2015 Gangzheng Tong. All rights reserved.
//

#import "GZTGlobalModule.h"

@implementation GZTGlobalModule
static NSString *selectedCid = @"";
static Lecture *selectedLecture;
static NSArray *alllectures;

static GZTSettingViewController *sc;
static GZTCourseViewController *cc;
static GZTLectureViewController *lc;


+(void) setSelectedCid: (NSString *)cid{
    selectedCid = cid;
}
+(NSString *)selectedCid{
    return selectedCid;
}

+(NSArray *)allLectures{
    if (!alllectures){
        alllectures = [[LibraryAPI sharedInstance] getLectures];
    }
    
    return alllectures;
}

+(void) setSelectedLecture: (Lecture *)lec{
    selectedLecture = lec;
}
+(Lecture *)selectedLecture{
    return selectedLecture;
}


+(void) setSettingViewController: (GZTSettingViewController *)vc{
    sc = vc;
}
+(GZTSettingViewController *) settingViewController{
    return sc;
}

+(void) setCourseViewController: (GZTCourseViewController *)vc{
    cc = vc;
}
+(GZTCourseViewController*) courseViewController{
    return cc;
}

+(void) setLectureViewController: (GZTLectureViewController *)vc{
    lc = vc;
}
+(GZTLectureViewController*) LectureViewController{
    return lc;
}


@end
