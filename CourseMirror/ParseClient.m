//
//  ParseClient.m
//  CourseMirror
//
//  Created by 童罡正 on 8/2/15.
//  Copyright (c) 2015 Gangzheng Tong. All rights reserved.
//

#import "ParseClient.h"
#import "Question.h"
#import "GZTUtilities.h"
#import "LibraryAPI.h"
#import "Summary.h"


@implementation ParseClient

static NSArray *allTokens;

+(NSDictionary *)downloadImages{
    NSMutableDictionary *key_image = [[NSMutableDictionary alloc] init];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Image"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if(objects){
            for(PFObject *object in objects){
                 PFFile *userImageFile = object[@"image"];
                [userImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
                    if (!error) {
                        UIImage *image = [UIImage imageWithData:imageData];
                        [key_image setObject:image forKey:object[@"key"]];
                    }
                }];
            }
        }
    }];
    
    return key_image;
}

+(NSArray *) getCouses{
    __block NSMutableArray *courses = [[NSMutableArray alloc] init];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Course"];
 //   [query whereKey:@"playerName" equalTo:@"Dan Stemkoski"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            for (PFObject *object in objects) {
                
                Course *course = [[Course alloc] initWithCid:object[@"cid"] Title:object[@"Title"] URL:object[@"URL"] Questions:object[@"questions"] Time:object[@"time"] Tokens:object[@"tokens"] image:object[@"cid"]];
                
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
                NSArray *questions = [GZTUtilities getArrayFromString:object[@"questions"]];

                Lecture *lecture = [[Lecture alloc] initWithCid:object[@"cid"] Title:object[@"Title"] date:object[@"date"] number:object[@"number"] questions: questions];

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
                
                NSString *t= object[@"QuestionType"];
                
                Question *question = [[Question alloc] initWithQid:object[@"QuestionID"] desc:object[@"QuestionDescription"] subDesc:object[@"QuestionSubDescription"] options:object[@"Choices"] type: [t integerValue]];                
                [questions addObject: question];
                
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    return questions;
}


+(void)setTokens: (NSArray *)tokens forUser: (PFUser *)user{
    NSString *tokenStr = [GZTUtilities getStringFromArray:tokens];
    user[@"token"] = tokenStr;
    
   // NSLog(@"(in ParseClient) tokens saved for user: %@", tokenStr);

    [user saveInBackground];
}

+(NSArray *)tokensforUser: (PFUser *)user{
    NSString *tokenString = user[@"token"];
    if(!tokenString) return  nil;
    NSArray *arr = [GZTUtilities getArrayFromString:tokenString];
   // NSLog(@"(in ParseClient) get tokens from user: %@", arr);
    
    return arr;
}


+(NSArray *)allTokens{
    NSMutableArray *alltokens = [[NSMutableArray alloc] init];
    for (Course *c in [[LibraryAPI sharedInstance] getCourses]){
        [alltokens addObjectsFromArray:c.tokens];
    }
    
    return alltokens;
}


+(Summary *)getSummaryForLecture:(Lecture*)lec{
    PFQuery *S_query = [PFQuery queryWithClassName:@"Summarization"];
    [S_query whereKey:@"cid" equalTo: [lec cid]];
    [S_query whereKey:@"lecture_number" equalTo:[lec number]];
    
    NSMutableArray *dic_arr = [[NSMutableArray alloc] init];

    PFObject *object = [S_query getFirstObject];
    if (!object) {
        NSLog(@"The S_object request failed.");
        return nil;
    }else {
        //iterate all questions of the lecture
        NSLog(@"[lec questions] count = %lu", [lec questions].count);
        for(int i =0; i< [[lec questions] count]; i++){
        NSString *name = [ NSString stringWithFormat:@"q%d_summaries", (i+1)];
           // NSLog(@"in Parseclient , name = %@", name );
        NSDictionary *summary_dic = [GZTUtilities getDictionaryFromString:object[name]];
           // NSLog(@"in Parseclient , summary_dic = %@", summary_dic );

        [dic_arr addObject:summary_dic];
           }
    }
    
    Summary *summary = [[Summary alloc] initWith:[lec cid] number:[lec number] infoArray:dic_arr];
    
    return summary;
}

//return Dictionary of Summary of all lectures
//key: lecture number, value: Summary
+(NSDictionary *)getSummariesForCourse:(Course*)course{
    
    NSArray *lectures = [[LibraryAPI sharedInstance] getLecturesForCid:[course cid]];
    NSDictionary *num_lectures = [GZTUtilities DictionaryFromArray:lectures WithKey:@"number"];
    
    
    PFQuery *S_query = [PFQuery queryWithClassName:@"Summarization"];
    [S_query whereKey:@"cid" containsString:[course cid]];
    NSMutableDictionary *num_summary = [[NSMutableDictionary alloc] init];
    
    
    [S_query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!objects) {
            NSLog(@"The findObjects request failed.");
        } else {
            // The find succeeded.
            //iterate all summaries of lectures
            for(PFObject *object in objects){
                //iterate all questions of the summay
                NSMutableArray *dic_arr = [[NSMutableArray alloc] init];
                Lecture *lec = [num_lectures objectForKey:object[@"lecture_number"]];
                
                for(int i =0; i< [[lec questions] count]; i++){
                    NSString *name = [ NSString stringWithFormat:@"q%d_summaries", (i+1)];
                    
                    NSDictionary *summary_dic = [GZTUtilities getDictionaryFromString:object[name]];
                    [dic_arr addObject:summary_dic];
                }
                
                [num_summary setObject:dic_arr forKey:object[@"lecture_number"]];
            }
        
        }
    }];
    

    return num_summary;
}

@end
