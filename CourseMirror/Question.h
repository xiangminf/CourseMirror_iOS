//
//  Question.h
//  CourseMirror
//
//  Created by 童罡正 on 7/31/15.
//  Copyright (c) 2015 Gangzheng Tong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Question : NSObject
@property (nonatomic, copy, readonly) NSString *Qid;
@property (nonatomic, copy, readonly) NSString *desc, *subDesc;
@property (nonatomic, copy, readonly) NSArray *options;


-(id)initWithQid: (NSString*)QuestionID desc:(NSString*)QuestionDescription subDesc:(NSString*)QuestionSubDescription options:(NSString*)options;



@end

