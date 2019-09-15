//
//  Extensions.swift
//  AmusementParkPassGenerator
//
//  Created by Gavin Butler on 07-09-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation
import UIKit

extension UIDatePicker {
    //Set default data for when the date picker is first displayed
    func setDefaultData() {
        let dateFormatter = formattedDateFormatter()
        if let defaultDate = dateFormatter.date(from: "01 Jan 2000") {
            self.date = defaultDate
        }
    }
    
    //For sample data population
    func setTestData() {
        let dateFormatter = formattedDateFormatter()
        if let defaultDate = dateFormatter.date(from: "13 Aug 2005") {
            self.date = defaultDate
        }
    }
    
    //Internal helper function to set a standard date format
    private func formattedDateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter
    }
}
