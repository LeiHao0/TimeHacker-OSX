//
//  THCalender.swift
//  TimeHacker
//
//  Created by Art on 12/15/15.
//  Copyright © 2015 Art. All rights reserved.
//

import Foundation
import EventKit

struct THCalender {
    
    typealias THEventData = (title:String, startDate:NSDate, endDate:NSDate)
    
    let store = EKEventStore()
    
    init() {
        getGrant()
    }
    
    func FetchingEvents(startDate:NSDate, endDate:NSDate) -> [EKEvent] {

        let predicate = store.predicateForEventsWithStartDate(startDate, endDate: endDate, calendars: nil)
        
        // Fetch all events that match the predicate
        return store.eventsMatchingPredicate(predicate)
    }
    
    func newEvent(data:THEventData) -> EKEvent {
        let event = EKEvent(eventStore: store)
        (event.title, event.startDate, event.endDate) = data
        // TODO: EKCalender
        event.calendar = store.defaultCalendarForNewEvents
        
        return event
    }
    
    func saveEvent(event: EKEvent) {
        do {
            try store.saveEvent(event, span: EKSpan.ThisEvent, commit: true)
        } catch let err {
            print(err)
        }
    }
    
    
    private func getGrant() {
        store.requestAccessToEntityType(EKEntityType.Event) { (granted, error) -> Void in
            // handle access here
        }
    }
}