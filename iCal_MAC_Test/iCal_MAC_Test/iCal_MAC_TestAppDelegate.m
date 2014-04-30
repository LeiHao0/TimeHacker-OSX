//
//  iCal_MAC_TestAppDelegate.m
//  iCal_MAC_Test
//
//  Created by artwalk on 4/29/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "iCal_MAC_TestAppDelegate.h"
#import <EventKit/EventKit.h>

@implementation iCal_MAC_TestAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    
    EKEventStore *store = [[EKEventStore alloc]
                           initWithAccessToEntityTypes:EKEntityMaskEvent];
    [self printEvents:store];
    
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
    
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:5];
    
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

@end
