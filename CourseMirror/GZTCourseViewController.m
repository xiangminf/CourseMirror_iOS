//
//  GZTCourseViewController.m
//  CourseMirror
//
//  Created by 童罡正 on 7/31/15.
//  Copyright (c) 2015 Gangzheng Tong. All rights reserved.
//

#import "GZTCourseViewController.h"
#import "UIColor+PDD.h"
#import "Course.h"
#import "CourseCellTableViewCell.h"
#import "GZTLectureViewController.h"
#import "GZTGlobalModule.h"
#import "GZTUtilities.h"

@interface GZTCourseViewController (){
    NSDictionary *cid_token;
    NSArray *addedCourse ;
}

@end

@implementation GZTCourseViewController

-(id)initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle: style];
    if(self){
        self.title = @"Courses";
        self.tabBarItem.title = @"Courses";
        self.tabBarItem.image = [UIImage imageNamed:@"course"];
    //    self.tableView.backgroundColor = [UIColor pddContentBackgroundColor];
        self.tableView.separatorColor = [UIColor pddSeparatorColor];
        self.tableView.separatorInset = UIEdgeInsetsZero;

    }
    
    return self;
}


-(void) viewDidLoad{
    [super viewDidLoad];
    
    // set refresh control
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor blackColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(refresh)
                  forControlEvents:UIControlEventValueChanged];
    
    // Hide extra table cell separators
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    self.tableView.separatorColor = [UIColor clearColor];

    [self refresh];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [addedCourse count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CourseCellTableViewCell *cell = (CourseCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CourseCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.title.text =[(Course*)addedCourse[indexPath.row] Title];
    cell.cid.text =[(Course*)addedCourse[indexPath.row] cid];
    //cell.textLabel.text = [(Course*)addedCourse[indexPath.row] Title];
    
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CourseCellTableViewCell *cell = (CourseCellTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    NSString *cid = cell.cid.text;
    
    //store selected cid
    [GZTGlobalModule setSelectedCid:cid];
    Course *course = [[LibraryAPI sharedInstance] getCourseForCid:cid];
//    [[LibraryAPI sharedInstance] getSummariesForCourse:course];
    
    // go to lecture view
    GZTLectureViewController *lectureViewController = [[GZTLectureViewController alloc] init];
    
    [self.navigationController pushViewController:(UIViewController *)lectureViewController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CourseCell" owner:self options:nil];
    
    return   ((CourseCellTableViewCell*)[nib objectAtIndex:0]).frame.size.height
;
}





- (void)refresh{
    if(![PFUser currentUser]){
        [self.refreshControl endRefreshing];
        return;
    }
    
    NSArray *tokens = [[LibraryAPI sharedInstance] tokensforUser:[PFUser currentUser]];
    if(!tokens){
        [self.refreshControl endRefreshing];
        addedCourse = @[];
        return;
    }
    
    addedCourse = [[LibraryAPI sharedInstance] addedCoursesForTokens:tokens];
    [self.tableView reloadData];
    [self.view setNeedsDisplay];
    
    [self.refreshControl endRefreshing];

}

@end
