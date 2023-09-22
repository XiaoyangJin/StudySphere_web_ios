//
//  DateFormatter+Extensions.swift
//  StudyTogether
//
//  Created by Team 24 on 4/9/23.
//

import Foundation

extension DateFormatter {
    static var postFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }()
}
