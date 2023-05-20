//
//  TopResponse.swift
//  GymCare
//
//

import Foundation

class TopResponse: Codable {

    var banners: [BannerModel]?
    var notifications: [NotificationModel]?
    var totalNotificationsUnread: Int?
    var totalReminderUnread: Int?
    var totalPeePooUnread: Int?
    var totalTopicUnread: Int?
    var totalSurveySheetUnread: Int?
    var totalExtracurricularUnread: Int?

    enum CodingKeys: String, CodingKey {
        case banners
        case notifications
        case totalNotificationsUnread = "total_notifications_unread"
        case totalReminderUnread = "total_reminder_unread"
        case totalPeePooUnread = "total_pee_poo_unread"
        case totalTopicUnread = "total_topic_unread"
        case totalSurveySheetUnread = "total_survey_sheet_unread"
        case totalExtracurricularUnread = "total_extracurricular_unread"
    }

}
