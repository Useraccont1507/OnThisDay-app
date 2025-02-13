//
//  EventModel.swift
//  OnThisDay
//
//  Created by Illia Verezei on 13.02.2025.
//

import Foundation

// MARK: - Events
struct Events: Codable {
    let selected: [Selected]
}

// MARK: - Selected
struct Selected: Codable {
    let text: String
    let pages: [Page]
    let year: Int
}

// MARK: - Page
struct Page: Codable {
    let type: TypeEnum
    let title, displaytitle: String
    let namespace: Namespace
    let wikibaseItem: String
    let titles: Titles
    let pageid: Int
    let thumbnail, originalimage: Originalimage?
    let lang: Lang
    let dir: Dir
    let revision, tid: String
    let timestamp: Date
    let description: String
    let descriptionSource: DescriptionSource
    let contentUrls: ContentUrls
    let extract, extractHtml, normalizedtitle: String
    let coordinates: Coordinates?

    enum CodingKeys: String, CodingKey {
        case type, title, displaytitle, namespace
        case wikibaseItem = "wikibase_item"
        case titles, pageid, thumbnail, originalimage, lang, dir, revision, tid, timestamp, description
        case descriptionSource = "description_source"
        case contentUrls = "content_urls"
        case extract
        case extractHtml = "extract_html"
        case normalizedtitle, coordinates
    }
}

// MARK: - ContentUrls
struct ContentUrls: Codable {
    let desktop, mobile: Desktop
}

// MARK: - Desktop
struct Desktop: Codable {
    let page, revisions, edit, talk: String
}

// MARK: - Coordinates
struct Coordinates: Codable {
    let lat, lon: Double
}

enum DescriptionSource: String, Codable {
    case local = "local"
}

enum Dir: String, Codable {
    case ltr = "ltr"
}

enum Lang: String, Codable {
    case en = "en"
}

// MARK: - Namespace
struct Namespace: Codable {
    let id: Int
    let text: String
}

// MARK: - Originalimage
struct Originalimage: Codable {
    let source: String
    let width, height: Int
}

// MARK: - Titles
struct Titles: Codable {
    let canonical, normalized, display: String
}

enum TypeEnum: String, Codable {
    case standard = "standard"
}
