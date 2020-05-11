//
//  TimeService.swift
//  Projectment
//
//  Created by Anar on 11.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

struct TimeService<T: BinaryInteger> {
  static var secondsInWeek : T { 604_800 }
  static var secondsInDay  : T { 86_400 }
  static var secondsInHour : T { 3_600 }
  
  static func secondsIn(daysCount: T) -> T {
    guard daysCount >= 0 else { return 0 }
    
    return TimeService.secondsInDay * daysCount
  }
}
