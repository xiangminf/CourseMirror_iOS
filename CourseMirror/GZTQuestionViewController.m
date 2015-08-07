
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
#import "QuestionView2.h"
#import "Question.h"
#import "QuestionView1Cell.h"

@interface GZTQuestionViewController (){
    QuestionView1 *view1;
    QuestionView1 *view2;

    NSMutableArray *allViews;
    NSArray *questions;
    NSArray *currentOptions;
    UIView *subView;
    int currentIndex;
}

@end

@implementation GZTQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    questions = [[LibraryAPI sharedInstance] getQuestions];
    allViews = [[NSMutableArray alloc] init];

    //build views array
    for(Question *q in questions){
        // multiply choice
        if( q.type == 2){
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"QuestionView1" owner:self options:nil];
            
            view1 = [nib objectAtIndex:0];
            view1.options.delegate = self;
            view1.options.dataSource = self;
            
            [view1 setNeedsDisplay];
            [allViews addObject:view1];
        }
        
        //
        if( q.type == 1 ){
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"QuestionView2" owner:self options:nil];
            
            view2 = [nib objectAtIndex:0];
            
            [view2 setNeedsDisplay];
            [allViews addObject:view2];
        }
    }// end building views array
    
    [_next setTitle:@"NEXT" forState:UIControlStateNormal];
    _next = [[UIButton alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height-100, 40, 10)];
             
    
     //set button
    [_next addTarget:self
              action:@selector(goToNext:)
    forControlEvents:UIControlEventTouchUpInside];
    [_previous addTarget:self action:@selector(goToPre:) forControlEvents:UIControlEventTouchUpInside];
    [_submit addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    _submit.hidden = YES;
    
    
    currentIndex = 0;
    [self showDataForQuestionAtIndex:currentIndex];
    [self.view addSubview:subView];
    [self.view addSubview:_next];
    [self.view addSubview:_previous];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self
               action:@selector(goToNext:)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"next" forState:UIControlStateNormal];
    button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    [self.view addSubview:button];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button2 addTarget:self
               action:@selector(goToPre:)
     forControlEvents:UIControlEventTouchUpInside];
    [button2 setTitle:@"previous" forState:UIControlStateNormal];
    button2.frame = CGRectMake(180.0, 210.0, 160.0, 40.0);
    [self.view addSubview:button2];
    
    [self.view setNeedsDisplay];



}


-(void)showDataForQuestionAtIndex:(int)index{
    
    //defensive code
    if(index < allViews.count){
        
        subView = allViews[index];
        
        //if it's type2, reload the table
        if( [(Question*)questions[index] type] == 2){
            Question *q = questions[index];
            currentOptions = [q options];
             view1 = allViews[index];
            [view1.options reloadData];
        }
    }else{
        NSLog(@"invalid index %d", index);
    }
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return currentOptions.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    QuestionView1Cell *cell = (QuestionView1Cell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"QuestionView1Cell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.text = currentOptions[indexPath.row];
    
    return  cell;
}




-(void)goToPre:(UIButton *)paramSender{
    _submit.hidden = YES;
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
        _submit.hidden = NO;
    }else{
        currentIndex ++;
        if(currentIndex == [questions count]-1){
            //in last page
            _submit.hidden = NO;
        }
        [self showDataForQuestionAtIndex:currentIndex];
    }
}

-(void)submit:(UIButton *)paramSender{
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
