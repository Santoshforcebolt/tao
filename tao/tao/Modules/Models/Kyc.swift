//
//  KycStatus.swift
//  tao
//
//  Created by Mayank Khursija on 26/06/22.
//

import Foundation

struct KycStatus: Codable {
    var verified: Bool?
    var status: String?
    var remark: String?
}

struct KycDocument: Codable {
    var competitionId: String?
    var key: String?
    var s3Bucket: String?
    var s3Url: String?
    var thumbnailUrl: String?
    var url: String?
    var userId: String?
}
