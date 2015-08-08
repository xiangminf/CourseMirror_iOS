//
//  LocalData.m
//  CourseMirror
//
//  Created by 童罡正 on 8/2/15.
//  Copyright (c) 2015 Gangzheng Tong. All rights reserved.
//

#import "LocalData.h"
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
    if(!_allquestions){
     _allquestions  =  [ParseClient getQuestions];
        
    }
    
    return _allquestions;
}

-(void)addToken: (NSString *)token forUser: (PFUser *)user{
    if(!_user_tokens){
        _user_tokens = [[NSMutableDictionary alloc] init];
     
    }
    NSMutableArray *arr = [_user_tokens objectForKey:user[@"username"]];
    if(!arr){
        arr = [[NSMutableArray alloc] init];
        [_user_tokens setObject:arr forKey:user[@"username"]];
    }
    if( ![arr containsObject: token]){
        [arr addObject: token];
        [ParseClient setTokens:arr forUser:user];
        NSLog(@"%@ is added", token);
    }else{
        NSLog(@"%@ is already there", token);
    }

}


-(NSArray *)tokensforUser: (PFUser *)user{
    NSArray *arr = [_user_tokens objectForKey:user[@"username"]];
    if(!arr){
        arr = [ParseClient tokensforUser:user];
    }
    return arr;
}

-(NSMutableArray *)getArrayforUser:(PFUser *)user{
    NSMutableArray *arr = [_user_tokens objectForKey:user[@"username"]];
    // if the array hasnt been created
    if(!arr){
        arr = [[NSMutableArray alloc] init];
    }
    
    return arr;
}

-(Summary *)getSummaryForLecture:(Lecture*)lec{
    if(!_lec_summary){
        _lec_summary = [[NSMutableDictionary alloc] init];
    }
    
    
    NSArray *arr = [_lec_summary objectForKey:[lec Title]];
    if(!arr){
        [ParseClient getSummaryForLecture:lec];
    }
    
    return [ParseClient getSummaryForLecture:lec];
}

-(NSDictionary *)getSummariesForCourse:(Course*)course{
    if(! _course_dicOfsummary){
        _course_dicOfsummary = [[NSMutableDictionary alloc] init];
    }
    NSDictionary *dicOfsummary =  [_course_dicOfsummary objectForKey:[course cid]];
    if(dicOfsummary){
        return dicOfsummary;
    }
    dicOfsummary =[ParseClient getSummariesForCourse:course];
    [_course_dicOfsummary setObject:dicOfsummary forKey:[course cid]];
    
    return dicOfsummary;
}

-(NSArray *)addedCoursesForTokens: (NSArray *)tokens{
   
    
   NSMutableArray *addedCourses = [[NSMutableArray alloc] init];
    NSArray *allCourses = [self getCourses];
    for(NSString *token in tokens){
        for(Course *c in allCourses){
            if( [[c tokens] containsObject:token]){
                [addedCourses addObject:c];
                break;
            }
        }
    }
    return addedCourses;
}

@end
