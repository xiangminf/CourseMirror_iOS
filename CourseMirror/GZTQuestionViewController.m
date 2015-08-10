
//
//  GZTQuestionViewController.m
//  CourseMirror
//
//  Created by 童罡正 on 8/3/15.
//  Copyright (c) 2015 Gangzheng Tong. All rights reserved.
//

#import "GZTQuestionViewController.h"
#import "LibraryAPI.h"
#import "GZTQuestionVC1.h"
#import "GZTQuestionVC2.h"
#import "Question.h"
#import "QuestionView1Cell.h"
#import "GZTGlobalModule.h"

@interface GZTQuestionViewController (){
    NSMutableArray *contentVCs;
    BOOL completed;
    int currentIndex;
}

@end

@implementation GZTQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    completed = false;

    _answers = [[NSMutableDictionary alloc] init];
    // get array of Question
    _questions = [[LibraryAPI sharedInstance] getQuestions];
    contentVCs = [[NSMutableArray alloc] init];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"GZTMain"
                                                             bundle: nil];

    //build content controller array based on question type
    for(Question *q in _questions){
        // multiply choice
        if( q.type == 2){
            GZTQuestionVC1 *vc2 = [storyboard instantiateViewControllerWithIdentifier:@"QuestionVC2"];
            
            vc2.titleText =[q desc];
           
            NSLog(@" vc2.label.text = [q desc]; = %@", [q desc]);
            
            //tobedone
            [contentVCs addObject:vc2];
        }
        //
        if( q.type == 1 ){
            GZTQuestionVC1 *vc1 = [storyboard instantiateViewControllerWithIdentifier:@"QuestionVC1"];
            vc1.titleText =[q desc];
            [contentVCs addObject:vc1];
        }
    }// end building views array
    
    
    // Create page view controller
    self.pageViewController = [storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    
    UIViewController *startingViewController = [contentVCs objectAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 130);
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
    
    _submit.hidden = YES;
    currentIndex = 0;

}



//-(void)showDataForQuestionAtIndex:(int)index{
//    
//    //defensive code
//    if(index < allViews.count){
//        
//        subView = allViews[index];
//        
//        //if it's type2, reload the table
//        if( [(Question*)questions[index] type] == 2){
//            Question *q = questions[index];
//            currentOptions = [q options];
//             view1 = allViews[index];
//            [view1.options reloadData];
//        }
//    }else{
//        NSLog(@"invalid index %d", index);
//    }
//}



- (IBAction)goToPre:(id)sender {
    _submit.hidden = YES;
    if(currentIndex == 0){
        NSLog(@"first page");
    }else{
        currentIndex --;
        if(currentIndex == 0){
            //in first page
        }
        [self.pageViewController setViewControllers:@[contentVCs[currentIndex]] direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];

    }
}


- (IBAction)goToNext:(id)sender {
    
    if(currentIndex == [contentVCs count]-1){
        NSLog(@"last page");
      //  _submit.hidden = NO;
    }else{
        currentIndex ++;
        if(currentIndex == [contentVCs count]-1){
            //in last page
            _submit.hidden = NO;
        }
        [self.pageViewController setViewControllers:@[contentVCs[currentIndex]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    }
}


- (IBAction)submit:(id)sender {
    NSLog(@"submit pressed");
    
    int index = 0;
    for(Question *q in _questions){
        NSString *ans;
        
        
        if( q.type == 1){
            ans = [[(GZTQuestionVC1*)contentVCs[index] textView] text];
        }else{
            ans = [contentVCs[index] answer];

        }
        
        if(!ans){
              [[[UIAlertView alloc] initWithTitle:@"Not Completed." message:@"Please answer all questions." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Done", nil] show];
            break;
        }
        [_answers setObject:ans forKey: [q Qid]];
        index ++;
    }
    //completed
    if(index ==  [contentVCs count]){
        index = 0;
        PFObject *reflection = [PFObject objectWithClassName:@"Reflection"];
        
        reflection[@"lecture_number"] = [[GZTGlobalModule selectedLecture] number];
        
        reflection[@"cid"] = [[GZTGlobalModule selectedLecture] cid];
        reflection[@"user"] =[GZTGlobalModule getActiveToken];
        for(Question *q in _questions){
            reflection[[q Qid]] = [_answers objectForKey:[q Qid]];

            index ++;
            //[NSString stringWithFormat:@"%@||Rating: %d", s0, (int)i0];
        }
    [reflection saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // The object has been saved.
            [[[UIAlertView alloc] initWithTitle:@"Submitted" message:@"Thank you!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Done", nil] show];
            
        } else {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Please check network!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Done", nil] show];            }
    }];
        
    }

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    } else {
        NSLog(@"Clicked button index other than 0");
        // Add another action here
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
