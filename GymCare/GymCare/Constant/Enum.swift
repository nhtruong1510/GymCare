//
//  Enum.swift
//  SchoolUpTeacher
//
//  Created by Paraline App on 30/12/2022.
//

import Foundation

enum TypeChooseInOut: Int {
    case carDepart = 1
    case carReturn = 2
    case classs = 3
}

enum TypeView {
    case absence
    case shuttle
    case edit
    case create
    case detail
}

enum TypeCheckInOUT: String {
    case checkIn = "in"
    case checkOut = "out"
}

enum TypeAction {
    case ok
    case cancel
}


enum TypeCamera {
    case cameraDefault
    case cameraSchoolup
}

enum TypeWeekDay: String {
    case Monday = "Monday"
    case Tuesday = "Tuesday"
    case Wednesday = "Wednesday"
    case Thursday = "Thursday"
    case Friday = "Friday"
    case Saturday = "Saturday"
    case Sunday = "Sunday"
}

enum TypeChartDataView: Int {
    case height
    case weight
    case weightAndHeight
}

enum TypeAbsence: Int {
    case ABSENCE_NEW = 0
    case ABSENCE_APPROVED = 1
    case ABSENCE_CANCEL = 2
    case none
}

enum TypeShuttle: Int {
    case morning = 1
    case afternoon = 2
    case all = 3
    case none
}

enum RelationshipType: Int {
    case relationship_type_father = 0
    case relationship_type_mother = 1
    case relationship_type_grandfather = 2
    case relationship_type_grandmother = 3
    case relationship_type_auntie = 4
    case relationship_type_uncle = 5
    case relationship_type_guardian = 6
    case relationship_type_supervisor = 7
    case relationship_type_carer = 8
    case relationship_type_maid = 9
    case relationship_type_other = 10
    case none
}

enum TypeChooseButton: Int {
    case edit
    case confirm
    case delete
}

enum TypeTapGesture {
    case keyboard
    case dissMissView
}

enum TypeChooseDate: Int {
    case startDate
    case endDate
}

enum TypeDatePicker {
    case date
    case month
    case year
    case time
}

enum TypeInOut: Int {
    case checkIn = 1
    case checkOut = 2
    case inOutClass
    case inOutCar
}

enum TypeChooseFillData: Int {
    case all = 1
    case toDay = 2
}

enum TypeFile: Int {
    case PDF
    case XLSX
}

enum TypeAlert {
    case confirm
    case cancel
}
