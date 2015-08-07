//
//  Question.m
//  CourseMirror
//
//  Created by 童罡正 on 7/31/15.
//  Copyright (c) 2015 Gangzheng Tong. All rights reserved.
//

#import "Question.h"

@implementation Question

-(id)initWithQid: (NSString*)QuestionID desc:(NSString*)QuestionDescription subDesc:(NSString*)QuestionSubDescription options:(NSString*)options type: (NSInteger)type{
    
    self = [super init];
    if(self){
        _Qid = QuestionID;
        _desc = QuestionDescription;
        _subDesc = QuestionSubDescription;
        _type = type;
        if(options){
            //parse options
            NSData *jsonData = [options dataUsingEncoding:NSUTF8StringEncoding];
            NSError *localError;
            _options = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&localError];
        }
        
    }
    
    return self;
}
@end

