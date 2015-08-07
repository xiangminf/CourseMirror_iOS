//
//  Summary.m
//  CourseMirror
//
//  Created by 童罡正 on 8/6/15.
//  Copyright (c) 2015 Gangzheng Tong. All rights reserved.
//

#import "Summary.h"

@implementation Summary

-(id)initWith:(NSString*)cid number:(NSString*)num infoArray:(NSArray*)infoArray{
    
    self= [super init];
    
    if(self){
        _cid = cid;
        _lec_num = num;
        _infoDictionaryArray = infoArray;
    }
    
    return self;
}



-(NSArray *)getTextArray{
    if(! _infoDictionaryArray) return nil;
    
    
    
    
    return nil;
}

@end
