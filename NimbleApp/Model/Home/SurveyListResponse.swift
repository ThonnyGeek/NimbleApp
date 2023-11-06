//
//  SurveyListResponse.swift
//  NimbleApp
//
//  Created by Thony Gonzalez on 6/11/23.
//

import Foundation

struct SurveyListResponse: Decodable {
    var data: [SurveyListData]?
    var meta: Meta?
    var errors: [ResponseError]?
}

// MARK: - SurveyListData
struct SurveyListData: Decodable, Hashable {
    var id, type: String
    var attributes: SurveyListDataAttributes
}

// MARK: - Attributes
struct SurveyListDataAttributes: Decodable, Hashable {
    var title, description: String
//    var thankEmailAboveThreshold, thankEmailBelowThreshold: String?
//    var isActive: Bool
    var coverImageURL: String
//    var createdAt, activeAt: String
//    var inactiveAt: JSONNull?
//    var surveyType: String

    enum CodingKeys: String, CodingKey {
        case title, description
//        case thankEmailAboveThreshold = "thank_email_above_threshold"
//        case thankEmailBelowThreshold = "thank_email_below_threshold"
//        case isActive = "is_active"
        case coverImageURL = "cover_image_url"
//        case createdAt = "created_at"
//        case activeAt = "active_at"
//        case inactiveAt = "inactive_at"
//        case surveyType = "survey_type"
    }
}

// MARK: - Meta
struct Meta: Decodable {
    var page, pages, pageSize, records: Int

    enum CodingKeys: String, CodingKey {
        case page, pages
        case pageSize = "page_size"
        case records
    }
}
