//
//  ParseClient.h
//  CourseMirror
//
//  Created by 童罡正 on 8/2/15.
//  Copyright (c) 2015 Gangzheng Tong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface ParseClient : NSObject

+(NSArray *) getCouses;
+(NSArray *) getLectures;
+(NSArray *) getQuestions;
@end
