//
//  Book.swift
//  StudySphere
//
//  Created by 靳肖阳 on 4/29/23.
//

import Foundation

struct BookResponse: Decodable {
    let items: [Book]
}

struct Book: Decodable {
    let kind: String
    let id: String
    let etag: String
    let selfLink: String
    let volumeInfo: VolumeInfo
    let saleInfo: SaleInfo
}

struct VolumeInfo: Decodable {
    let title: String
    let subtitle: String?
    let authors: [String]
    let publisher: String?
    let publishedDate: String?
    let description: String?
    let industryIdentifiers: [IndustryIdentifier]?
    let readingModes: ReadingModes?
    let pageCount: Int?
    let printType: String?
    let categories: [String]?
    let maturityRating: String?
    let allowAnonLogging: Bool?
    let contentVersion: String?
    let panelizationSummary: PanelizationSummary?
    let imageLinks: ImageLinks?
    let language: String?
    let previewLink: String?
    let infoLink: String?
    let canonicalVolumeLink: String?
}

struct IndustryIdentifier: Decodable {
    let type: String
    let identifier: String
}

struct ReadingModes: Decodable {
    let text: Bool
    let image: Bool
}

struct PanelizationSummary: Decodable {
    let containsEpubBubbles: Bool
    let containsImageBubbles: Bool
}

struct ImageLinks: Decodable {
    let smallThumbnail: String?
    let thumbnail: String?
}

struct SaleInfo: Decodable {
    let country: String?
    let saleability: String
    let isEbook: Bool
    let listPrice: Price?
    let retailPrice: Price?
    let buyLink: String?
    let offers: [Offer]?
}

struct Price: Decodable {
    let amount: Double?
    let currencyCode: String?
}

struct Offer: Decodable {
    let finskyOfferType: Int?
    let listPrice: Price?
    let retailPrice: Price?
    let rentalDuration: RentalDuration?
}

struct RentalDuration: Decodable {
    let unit: String?
    let count: Int?
}
