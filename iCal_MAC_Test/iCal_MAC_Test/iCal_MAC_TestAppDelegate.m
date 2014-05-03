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

@synthesize ibArrayController, ibButtonStartStop,ibTableView,ibTextFieldNotification,ibTextFieldTaskToDo,ibTextFieldTime;

@synthesize ibTableColumn,ibTextFieldCell;

@synthesize isStart, mCountingTimer, mEndDate, mStartDate, mTitle;

static NSString *keyReminders = @"Reminders";
static NSString *keyiCal = @"iCal";

-(void)awakeFromNib{
    [super awakeFromNib];
    
    [ibTableView setTarget:self];
    [ibTableView setDoubleAction:NSSelectorFromString(@"doubleClick:")];
//    [ibTableView setAction:NSSelectorFromString(@"click:")];
    
}

- (void) doubleClick: (id)sender
{
    if ([ibTableView selectedRow] >= 0) {
        NSString *s = [ibTextFieldCell stringValue];
        ibTextFieldTaskToDo.stringValue = s;
        ibTextFieldNotification.stringValue = @"Click Start";
        NSLog(@"cell value:%@", s);
    }
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    isStart = NO;
    [ibTableColumn setEditable:NO];
    [ibTextFieldCell setSelectable:YES];
    mTitle = @"";
    ibTextFieldNotification.stringValue = @"Click iReminders";
}


- (void) showReminders : (NSArray *) data {
    [self updateTableView:keyReminders withData:data];
}

- (void) showiCal : (NSArray *) data {
    [self updateTableView:keyiCal withData:data];
}

- (void)updateTableView : (NSString *) key withData:(NSArray *) data  {
    [self clearTableView];
    
    for (NSString *str in data) {
//        [mMutableDictionary setObject:str forKey:key];
        [ibArrayController addObjects:[NSArray arrayWithObject:[NSDictionary dictionaryWithObjectsAndKeys:str, key, nil]]];
    }
}

- (void)clearTableView {
    NSRange range = NSMakeRange(0, [[ibArrayController arrangedObjects] count]);
    [ibArrayController removeObjectsAtArrangedObjectIndexes:[NSIndexSet indexSetWithIndexesInRange:range]];
}

- (IBAction)startStop:(id)sender {
    if (!isStart) {
        if ([self startTask]) {
            ibButtonStartStop.title = @"Stop";
            isStart = !isStart;
        }
        
    } else {
        ibButtonStartStop.title = @"Start";
        [self stopTask];
        isStart = !isStart;
    }
    
}

- (void) paint:(NSTimer *)paramTimer{
    NSDate *now = [NSDate date];
    
    int secondsInterval = [now timeIntervalSinceDate:mStartDate];
    
    int iSeconds = secondsInterval  % 60;
    int iMinutes = secondsInterval / 60 %60;
    int iHours = secondsInterval / 3600;
    NSString *textFieldTime = [NSString stringWithFormat:@"%02d:%02d:%02d", iHours, iMinutes, iSeconds];
    
//    NSLog(@"%@", textFieldTime);
    
    ibTextFieldTime.stringValue = textFieldTime;
}

- (void) startCounting{
    
    self.mCountingTimer = [NSTimer
                           scheduledTimerWithTimeInterval:10
                           target:self selector:@selector(paint:) userInfo:nil repeats:YES];
}

- (void) stopCounting{
    if (self.mCountingTimer != nil){
        [self.mCountingTimer invalidate];
    }
    
    ibTextFieldTime.stringValue = @"00:00:00";
}

- (BOOL) startTask {
    if ([ibTextFieldTaskToDo.stringValue isEqualToString:@""]) {
        ibTextFieldNotification.stringValue = [NSString stringWithFormat:@"Task is empty! doubleClick one reminder"];
        return  NO;
    } else {
        mStartDate = [NSDate date];
        NSLog(@"%@", mStartDate);
        
        [self startCounting];
        
        return YES;
    }
}

- (void) stopTask {
    mEndDate = [NSDate date];
    NSLog(@"%@", mEndDate);
    [self stopCounting];
    
    mTitle = ibTextFieldTaskToDo.stringValue;
    
    NSString *notification;
    
    NSTimeInterval secondsInterval = [mEndDate timeIntervalSinceDate:mStartDate];
    
    if (secondsInterval > 10*60) {
        notification = [NSString stringWithFormat:@"TrueMan! '%@' insert to iCal...", mTitle];
        [self writeEvent2iCal];
    } else {
        notification = [NSString stringWithFormat:@"Oh, Man, only %.0fs...",  secondsInterval];
        NSLog(@"hehe");
    }
    
    ibTextFieldNotification.stringValue = notification;
}

- (void) writeEvent2iCal {
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    
    EKEvent *event = [EKEvent eventWithEventStore:eventStore];
    
    event.title = mTitle;
    event.endDate = mEndDate;
    event.startDate = mStartDate;
    
    //    NSTimeInterval interval = (60 *60)* -3 ;
    //    EKAlarm *alarm = [EKAlarm alarmWithRelativeOffset:interval];  //Create object of alarm
    //    [event addAlarm:alarm]; //Add alarm to your event
    
    [event setCalendar:[eventStore defaultCalendarForNewEvents]];
    NSError *err;
    NSString *ical_event_id;
    //save your event
    if([eventStore saveEvent:event span:EKSpanThisEvent commit:YES error:&err]){
        ical_event_id = event.eventIdentifier;
        NSLog(@"%@",ical_event_id);
    }
}

- (IBAction)iCalAnalytics:(id)sender {
    EKEventStore *store = [[EKEventStore alloc]
                           initWithAccessToEntityTypes:EKEntityMaskEvent];
    [store requestAccessToEntityType:EKEntityTypeReminder completion:^(BOOL granted,
                                                                       NSError *error) {
        [self showiCal:[self printEvents:store]];
    }];
}

- (IBAction)iReminders:(id)sender {
    
    
    EKEventStore *store = [[EKEventStore alloc]
                           initWithAccessToEntityTypes:EKEntityMaskReminder];

    [store requestAccessToEntityType:EKEntityTypeReminder completion:^(BOOL granted,
                                                                       NSError *error) {
        [self showReminders:[self printIncompleteReminders:store]];
    }];
}

- (NSArray *)printIncompleteReminders : (EKEventStore *) store {
    
    
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:5];
    
    NSPredicate *predicate = [store predicateForIncompleteRemindersWithDueDateStarting:nil ending:nil calendars:nil];
    [store fetchRemindersMatchingPredicate:predicate completion:^(NSArray *reminders) {
        
        for (EKReminder *reminder in reminders) {
            NSString *title = [NSString stringWithFormat:@"%@", reminder.title];
            NSLog(@"%@", title);
            [result addObject:title];
        }
    }];
    
    return result;
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
