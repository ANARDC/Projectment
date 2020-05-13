//
//  Observable.swift
//  Projectment
//
//  Created by Anar on 13.05.2020.
//  Copyright © 2020 Anar. All rights reserved.
//

import Foundation
import RxSwift

public protocol OptionalType {
  associatedtype Wrapped

  var optional: Wrapped? { get }
}

extension Optional: OptionalType {
  public var optional: Wrapped? { return self }
}

extension Observable where Element: OptionalType {
  func ignoreNil() -> Observable<Element.Wrapped> {
    self.flatMap { value in
      value.optional.map { Observable<Element.Wrapped>.just($0) } ?? Observable<Element.Wrapped>.empty()
    }
  }
}
