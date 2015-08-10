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

}

@end

@implementation LocalData

-(id)init{
 
    NSData *data = [NSData dataWithContentsOfFile:[NSHomeDirectory() stringByAppendingString:@"Documents/localData.bin"]];
    if(data == nil){
        self = [super init];
    }else{
        self = [ NSKeyedUnarchiver unarchiveObjectWithData:data];
        NSLog(@"in localData, init from archived data");

    }
    
    return self;
}

- (NSArray *) getCourses{
    if(!_allcourses){
       _allcourses = [ParseClient getCouses];
    }
    
    return _allcourses;
}

- (NSArray *) getLectures{
    if(!_alllectures){
        _alllectures = [ParseClient getLectures];
    }
    
    return _alllectures;
}

-(NSArray *)getQuestions{
    if(!_allquestions){
        _allquestions  =  [ParseClient getQuestions];
        
    }
    
    return _allquestions;
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

//tobedone
- (NSArray *) getCoursesForToken: (NSString *) token{
    return _allcourses;
}
- (NSArray *) getCoursesForcid: (NSString *) cid
{
    return _allcourses;
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
        arr = [ParseClient tokensforUser:user];
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
    NSLog(@"in localdata, allcourses  = %@", allCourses);

    for(NSString *token in tokens){
        for(Course *c in allCourses){
            if( [[c tokens] containsObject:token] && ![addedCourses containsObject:c]){
                [addedCourses addObject:c];
                break;
            }
        }
    }
    return addedCourses;
}


//archiving
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.allcourses forKey:@"allcourses"];
    [aCoder encodeObject:self.alllectures forKey:@"alllectures"];
    [aCoder encodeObject:self.allquestions forKey:@"allquestions"];
    [aCoder encodeObject:self.user_tokens forKey:@"user_tokens"];
    [aCoder encodeObject:self.lec_summary forKey:@"lec_summary"];
    [aCoder encodeObject:self.course_dicOfsummary forKey:@"course_dicOfsummary"];
    [aCoder encodeObject:self.key_image forKey:@"key_image"];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if(self){
        _allcourses = [aDecoder decodeObjectForKey:@"allcourses"];
        _alllectures =[aDecoder decodeObjectForKey:@"alllectures"];
        _allquestions = [aDecoder decodeObjectForKey:@"allquestions"];
        _user_tokens = [aDecoder decodeObjectForKey:@"user_tokens"];
        _lec_summary = [aDecoder decodeObjectForKey:@"lec_summary"];
        _course_dicOfsummary = [aDecoder decodeObjectForKey:@"course_dicOfsummary"];
        _key_image = [aDecoder decodeObjectForKey:@"key_image"];
    }
    return  self;
}

-(void)saveData{
    NSString *fileName = [NSHomeDirectory() stringByAppendingString:@"/Documents/localData.bin"];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    [data writeToFile:fileName atomically:YES];
}

-(NSDictionary *)downloadImages{
    if(!_key_image){
        _key_image = [ParseClient downloadImages];
    }
    return  _key_image;
}

-(void)sync{
    NSLog(@"sync called");

    _allcourses = [ParseClient getCouses];
    _alllectures = [ParseClient getLectures];
    _allquestions  =  [ParseClient getQuestions];
    _key_image = [ParseClient downloadImages];
    [self saveData];
}

@end
