//
//  LocalData.m
//  CourseMirror
//
//  Created by 童罡正 on 8/2/15.
//  Copyright (c) 2015 Gangzheng Tong. All rights reserved.
//

#import "LocalData.h"
#import "ParseClient.h"
#import "Lecture.h"

@interface LocalData(){
    NSArray *courses;
    NSArray *lectures;
}

@end

@implementation LocalData

- (NSArray *) getCourses{
    if(!courses){
       courses = [ParseClient getCouses];
    }
    
    return courses;
}

- (NSArray *) getLectures{
    if(!_alllectures){
        _alllectures = [ParseClient getLectures];
    }
    
    return _alllectures;
}

-(NSArray *)getLecturesForCid: (NSString *)cid{
    if(!_alllectures){
        _alllectures = [ParseClient getLectures];
    }
    

    NSMutableArray *cid_Lectures = [[NSMutableArray alloc] init];
    for(Lecture *lec in _alllectures){

        if( [[lec cid] isEqualToString:cid])
            [cid_Lectures addObject:lec];
    }
    
    return cid_Lectures;
}


- (NSArray *) getCoursesForToken: (NSString *) token{
 
    
    return courses;
}
- (NSArray *) getCoursesForcid: (NSString *) cid
{
    
    return courses;
}

-(NSArray *)getQuestions{
    if(!_alllectures){
     _allquestions  =  [ParseClient getQuestions];
        
    }
    
    return _allquestions;
}


@end
