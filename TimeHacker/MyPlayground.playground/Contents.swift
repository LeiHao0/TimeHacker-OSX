//: Playground - noun: a place where people can play

import Cocoa

import EventKit

let store = EKEventStore() // initWithAccessToEntityTypes:EKEntityMaskEvent
store.requestAccessToEntityType(EKEntityType.Event) { (granted, error) -> Void in

}

//let c = store.defaultCalendarForNewEvents