//
//  GZTGlobalModule.h
//  CourseMirror
//
//  Created by 童罡正 on 8/2/15.
//  Copyright (c) 2015 Gangzheng Tong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LibraryAPI.h"

@interface GZTGlobalModule : NSObject

+(void) setSelectedCid: (NSString *)cid;
+(NSString *)selectedCid;

+(NSArray *)allLectures;

+(void) setSelectedLecture: (Lecture *)cid;
+(Lecture *)selectedLecture;


@end
