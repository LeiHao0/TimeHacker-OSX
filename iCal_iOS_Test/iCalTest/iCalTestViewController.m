//
//  iCalTestViewController.m
//  iCalTest
//
//  Created by artwalk on 4/29/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "iCalTestViewController.h"
#import <EventKit/EventKit.h>

static NSString *CellIdentifier = @"Cell";

@interface iCalTestViewController ()

@end

@implementation iCalTestViewController

@synthesize myData;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    EKEventStore *store = [[EKEventStore alloc] init];
    
    [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        if (granted == YES) {
            NSLog(@"USER Granted");
            myData = [self printEvents:store];
            [self.tableView reloadData];
        }else{
            NSLog(@"USER Denied");
            // Do nothing
        }
        
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}
- (NSArray *)printEvents : (EKEventStore *) store {
    // Get the appropriate calendar
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // Create the start date components
    NSDateComponents *yearsAgoComponents = [[NSDateComponents alloc] init];
    yearsAgoComponents.year= -4;
    NSDate *yearsAgo = [calendar dateByAddingComponents:yearsAgoComponents
                                                 toDate:[NSDate date]
                                                options:0];
    
    // Create the end date components
    NSDateComponents *onedayFromNowComponents = [[NSDateComponents alloc] init];
    onedayFromNowComponents.day = 1;
    NSDate *oneDayFromNow = [calendar dateByAddingComponents:onedayFromNowComponents
                                                      toDate:[NSDate date]
                                                     options:0];
    // Create the predicate from the event store's instance method
    NSPredicate *predicate = [store predicateForEventsWithStartDate:yearsAgo
                                                            endDate:oneDayFromNow
                                                          calendars:nil];
    // Fetch all events that match the predicate
    NSArray *events = [store eventsMatchingPredicate:predicate];
    
    return [self analytics:events];
}

- (NSArray *)analytics : (NSArray *)events {
    NSMutableDictionary *calTimeDict = [NSMutableDictionary dictionary];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    
    for (EKEvent * event in events) {
        NSString *title = event.calendar.title;
        if ([title isEqualToString:@"US Holidays"]) {
            continue;
        }
        NSDateComponents *comps = [gregorian components:NSMinuteCalendarUnit fromDate:event.startDate  toDate:event.endDate  options:0];
        long minute = [comps minute];
        
        
        minute += [[calTimeDict objectForKey:title] longValue];
        [calTimeDict setObject:[NSNumber numberWithLong:minute] forKey:title];
    }
    
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:20];
    
    
    __block long sum = 0;
    [calTimeDict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        long l = [obj longValue]/60;
        sum += l;
        NSString *s = [NSString stringWithFormat:@"%@ : already %ld h,%ld h remained", key,l,10000-l];
        NSLog(@"%@", s);
        [result addObject:s];
    }];
    
    NSString *s = [NSString stringWithFormat:@"%ld h in Total", sum];
    [result addObject:s];
    NSLog(@"%@", s);
    
    [calTimeDict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        double f  = [obj longValue]/60 *100.0 / sum;
        NSString *s = [NSString stringWithFormat:@"%@ : %0.2f%%", key,f];
        NSLog(@"%@", s);
        [result addObject:s];
    }];
    
    return result;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - TableView Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.myData count];}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell == nil) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.text = [myData objectAtIndex:indexPath.row];
    
    return cell;
}


@end
