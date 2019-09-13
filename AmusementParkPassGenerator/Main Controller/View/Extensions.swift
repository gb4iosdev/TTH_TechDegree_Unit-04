//
//  Extensions.swift
//  AmusementParkPassGenerator
//
//  Created by Gavin Butler on 07-09-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation
import UIKit

//extension UIView {
//    //Used to determine if bottom fields are acting as first responders in order to move main stackview up and allow room for keyboard
//    func recursiveSubViews() -> [UIView] {
//        return subviews + subviews.flatMap { $0.recursiveSubViews() }
//    }
//}

extension UIDatePicker {
    func setDefaultData() {
        let dateFormatter = formattedDateFormatter()
        if let defaultDate = dateFormatter.date(from: "01 Jan 2000") {
            self.date = defaultDate
        }
    }
    
    func setTestData() {
        let dateFormatter = formattedDateFormatter()
        if let defaultDate = dateFormatter.date(from: "13 Aug 2005") {
            self.date = defaultDate
        }
    }
    
    func formattedDateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter
    }
}
