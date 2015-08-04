//
//  ParseClient.m
//  CourseMirror
//
//  Created by 童罡正 on 8/2/15.
//  Copyright (c) 2015 Gangzheng Tong. All rights reserved.
//

#import "ParseClient.h"
#import "Course.h"
#import "Lecture.h"
#import "Question.h"

@implementation ParseClient

+(NSArray *) getCouses{
    __block NSMutableArray *courses = [[NSMutableArray alloc] init];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Course"];
 //   [query whereKey:@"playerName" equalTo:@"Dan Stemkoski"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            for (PFObject *object in objects) {
                
                Course *course = [[Course alloc] initWithCid:object[@"cid"] Title:object[@"Title"] URL:object[@"URL"] Questions:object[@"questions"] Time:object[@"time"] Tokens:object[@"tokens"]];
                
                [courses addObject: course];
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    

    return courses;
}

+(NSArray *) getLectures{
    __block NSMutableArray *lectures = [[NSMutableArray alloc] init];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Lecture"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            for (PFObject *object in objects) {

                Lecture *lecture = [[Lecture alloc] initWithCid:object[@"cid"] Title:object[@"Title"] date:object[@"date"] number:object[@"number"]];

                [lectures addObject: lecture];
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    

    return lectures;
}

+(NSArray *) getQuestions{
    __block NSMutableArray *questions = [[NSMutableArray alloc] init];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Question"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            for (PFObject *object in objects) {
                
                Question *question = [[Question alloc] initWithQid:object[@"QuestionID"] desc:object[@"QuestionDescription"] subDesc:object[@"QuestionSubDescription"] options:object[@"Choices"] ];
                
                [questions addObject: question];
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    

    
    
    return questions;
    
}


@end
