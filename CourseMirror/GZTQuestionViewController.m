
//
//  GZTQuestionViewController.m
//  CourseMirror
//
//  Created by 童罡正 on 8/3/15.
//  Copyright (c) 2015 Gangzheng Tong. All rights reserved.
//

#import "GZTQuestionViewController.h"
#import "LibraryAPI.h"
#import "QuestionView1.h"
#import "Question.h"

@interface GZTQuestionViewController (){
    QuestionView1 *view;
    NSArray *allViews;
    NSArray *questions;
    NSArray *currentOptions;

    int currentIndex;
}

@end

@implementation GZTQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    questions = [[LibraryAPI sharedInstance] getQuestions];
    
    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CourseCell" owner:self options:nil];
    view = [nib objectAtIndex:0];
    view.options.delegate = self;
    view.options.dataSource = self;
    
    // set button
    [view.next addTarget:self
              action:@selector(goToNext:)
    forControlEvents:UIControlEventTouchUpInside];
    [view.previous addTarget:self action:@selector(goToPre:) forControlEvents:UIControlEventTouchUpInside];
    
    [self showDataForQuestionAtIndex:currentIndex];
}


-(void)showDataForQuestionAtIndex:(int)index{
    
    //defensive code
    if(index < questions.count){
        Question *q = questions[index];
        currentOptions = [q options];
    }else{
        currentOptions = nil;
    }
    
    [view.options reloadData];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return currentOptions.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return  nil;
}




-(void)goToPre:(UIButton *)paramSender{
    
    if(currentIndex == 0){
        NSLog(@"first page");
    }else{
        currentIndex --;
        if(currentIndex == 0){
            //in first page
        }
        [self showDataForQuestionAtIndex:currentIndex];
    }
}

-(void)goToNext:(UIButton *)paramSender{
    
    if(currentIndex == [questions count]-1){
        NSLog(@"last page");
    }else{
        currentIndex ++;
        if(currentIndex == [questions count]-1){
            //in last page
        }
        [self showDataForQuestionAtIndex:currentIndex];
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
