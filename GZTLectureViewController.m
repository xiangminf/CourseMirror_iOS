//
//  GZTLectureViewController.m
//  CourseMirror
//
//  Created by 童罡正 on 8/2/15.
//  Copyright (c) 2015 Gangzheng Tong. All rights reserved.
//

#import "GZTLectureViewController.h"
#import "UIColor+PDD.h"
#import "LibraryAPI.h"
#import "GZTGlobalModule.h"
#import "GZTLectureCell.h"
#import "GZTUtilities.h"
#import "GZTQuestionViewController.h"
#import "GZTSummaryTableViewController.h"

@interface GZTLectureViewController (){
    UITableView *lecTable;
    NSArray *lectures;
    
}

@end

@implementation GZTLectureViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //get lectures for cid
    NSString *cid = [GZTGlobalModule selectedCid];
    
    lectures = [[LibraryAPI sharedInstance] getLecturesForCid:cid];
    
    //create lecture table
    lecTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 120, self.view.frame.size.width, self.view.frame.size.height-120) style:UITableViewStylePlain];
    lecTable.delegate = self;
    lecTable.dataSource = self;
    lecTable.backgroundView = nil;
    
    [self.view addSubview:lecTable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [lectures count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"cell";
    GZTLectureCell *cell = (GZTLectureCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"GZTLectureCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    // Configure the cell to show lectures
    
    UIImage *image;
    NSDate *lectureDate = [lectures[indexPath.row] date];
    NSDate *now = [NSDate date];
    NSDate *twoDayAgo = [now dateByAddingTimeInterval:-60*60*24*2];

    if([lectureDate compare:twoDayAgo] == NSOrderedAscending){
        // lectureDate is earlier than twoDayAgo
        image = [UIImage imageNamed:@"closeImage.png"];
        cell.statusStr = @"closed";
    }else{
        if([lectureDate compare:now] == NSOrderedDescending){
            // lectureDate is later than twoDayAgo
            image = [UIImage imageNamed:@"upcomming.png"];
            cell.statusStr = @"upcoming";
        }else{
            image = [UIImage imageNamed:@"openImage.png"];
          //  openIndex = indexPath;
            cell.statusStr = @"open";
        }
    }
    cell.status.image = image;

    
    
    //    cell.status = nil;
    cell.title.text = [lectures[indexPath.row] Title];

    
    cell.number.text =[@(indexPath.row+1) stringValue] ;
    cell.date.text =   [[lectures[indexPath.row] date] description];

    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GZTLectureCell *cell = (GZTLectureCell*)[tableView cellForRowAtIndexPath:indexPath];
    
    //store selected lecture
    NSString *selectedLec = cell.title.text;
    NSDictionary *d = [GZTUtilities DictionaryFromArray:lectures WithKey:@"Title"];
    [GZTGlobalModule setSelectedLecture: [d objectForKey:selectedLec]];

    
    
    if( [cell.statusStr isEqualToString:@"closed"]){
        
       // GZTSummaryTableViewController   *SController = [[GZTSummaryTableViewController alloc] init];
        
        GZTSummaryTableViewController   *SController = [[GZTSummaryTableViewController alloc] initWithStyle:UITableViewStylePlain Lecture:[d objectForKey:selectedLec]];
        SController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:SController animated:YES];

    }else if([cell.statusStr isEqualToString:@"open"]){
        GZTQuestionViewController *QController = [[GZTQuestionViewController alloc] init];
        QController.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:QController animated:YES];

    }else{
        [[[UIAlertView alloc] initWithTitle:@"Not Open!" message:@"You can't write reflection for uncomming lectures." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Done", nil] show];
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"GZTLectureCell" owner:self options:nil];
    
    return   ((GZTLectureCell*)[nib objectAtIndex:0]).frame.size.height
    ;
}


@end
