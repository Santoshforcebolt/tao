//
//  getAppConfig.swift
//  tao
//
//  Created by Betto Akkara on 02/04/22.
//

import Foundation

// MARK: - GetAppConfig
struct GetAppConfig: Codable {
    var appVersionCode, latestAppVersionCode: Int?
    var latestAppVersion, appUpdateType: String?
    var appUpdateURL: String?
    var apkUpdateURL: String?
    var profileUpdatable: Bool?
    var minAmountPayout, minAmountAmazonPayout, maxUploadSize: Int?

    enum CodingKeys: String, CodingKey {
        case appVersionCode = "app_version_code"
        case latestAppVersionCode = "latest_app_version_code"
        case latestAppVersion = "latest_app_version"
        case appUpdateType = "app_update_type"
        case appUpdateURL = "app_update_url"
        case apkUpdateURL = "apk_update_url"
        case profileUpdatable = "profile_updatable"
        case minAmountPayout = "min_amount_payout"
        case minAmountAmazonPayout = "min_amount_amazon_payout"
        case maxUploadSize = "max_upload_size"
    }
}


