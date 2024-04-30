//
//  Media.swift
//  tao
//
//  Created by Mayank Khursija on 28/05/22.
//

import Foundation

struct MediaUploadDetails: Codable {
    var competitionId: String?
    var key: String?
    var s3Bucket: String?
    var s3Url: String?
    var thumbnailUrl: String?
    var url: String?
    var userId: String?
}

struct MediaDetails: Codable {
    var apiKey: String?
    var competitionId: String?
    var libraryId: String?
    var thumbnailUrl: String?
    var url: String?
    var userId: String?
    var videoId: String?
}

struct BunnyUploadDetails: Codable {
    var success: Bool?
    var message: String?
    var statusCode: Int?
}

struct TVItem: Codable {
    var body: TVMediaBody?
}

struct TVMedia: Codable {
    let userId : String?
    let userShared : Bool?
    let likes : Int?
    let competitionCategory : String?
    let shares : Int?
    let reported : Bool?
    let views : Int?
    let participantName : String?
    let competitionName : String?
    let name : String?
    let resourceURL : String?
    let id : String?
    let userLiked : Bool?
    let mediaType : String?
    let competitionSubCategory : String?
    let blocked : Bool?
    let thumbnailURL : String?
    let competitionId : String?
    let submittedTimestamp : String?
    let description : String?
}

struct TVMediaBody: Codable {
    var media: [TVMedia]?
    let nextCursor: String?
}

struct EmptyResponse: Codable {
    
}

struct ProfileMedia: Codable {
    var body: ProfileMediaBody?
}

struct ProfileMediaBody: Codable {
    var data: [TVMedia]?
}
