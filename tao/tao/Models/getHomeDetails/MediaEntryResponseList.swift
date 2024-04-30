/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct MediaEntryResponseList : Codable {
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
	let exploreScore : StringOrDouble?
	let userLiked : Bool?
	let mediaType : String?
	let competitionSubCategory : String?
	let blocked : Bool?
	let thumbnailURL : String?
	let competitionId : String?
	let submittedTimestamp : String?
	let description : String?

	enum CodingKeys: String, CodingKey {

		case userId = "userId"
		case userShared = "userShared"
		case likes = "likes"
		case competitionCategory = "competitionCategory"
		case shares = "shares"
		case reported = "reported"
		case views = "views"
		case participantName = "participantName"
		case competitionName = "competitionName"
		case name = "name"
		case resourceURL = "resourceURL"
		case id = "id"
		case exploreScore = "exploreScore"
		case userLiked = "userLiked"
		case mediaType = "mediaType"
		case competitionSubCategory = "competitionSubCategory"
		case blocked = "blocked"
		case thumbnailURL = "thumbnailURL"
		case competitionId = "competitionId"
		case submittedTimestamp = "submittedTimestamp"
		case description = "description"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		userId = try values.decodeIfPresent(String.self, forKey: .userId)
		userShared = try values.decodeIfPresent(Bool.self, forKey: .userShared)
		likes = try values.decodeIfPresent(Int.self, forKey: .likes)
		competitionCategory = try values.decodeIfPresent(String.self, forKey: .competitionCategory)
		shares = try values.decodeIfPresent(Int.self, forKey: .shares)
		reported = try values.decodeIfPresent(Bool.self, forKey: .reported)
		views = try values.decodeIfPresent(Int.self, forKey: .views)
		participantName = try values.decodeIfPresent(String.self, forKey: .participantName)
		competitionName = try values.decodeIfPresent(String.self, forKey: .competitionName)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		resourceURL = try values.decodeIfPresent(String.self, forKey: .resourceURL)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		exploreScore = try values.decodeIfPresent(StringOrDouble.self, forKey: .exploreScore)
		userLiked = try values.decodeIfPresent(Bool.self, forKey: .userLiked)
		mediaType = try values.decodeIfPresent(String.self, forKey: .mediaType)
		competitionSubCategory = try values.decodeIfPresent(String.self, forKey: .competitionSubCategory)
		blocked = try values.decodeIfPresent(Bool.self, forKey: .blocked)
		thumbnailURL = try values.decodeIfPresent(String.self, forKey: .thumbnailURL)
		competitionId = try values.decodeIfPresent(String.self, forKey: .competitionId)
		submittedTimestamp = try values.decodeIfPresent(String.self, forKey: .submittedTimestamp)
		description = try values.decodeIfPresent(String.self, forKey: .description)
	}

}


enum StringOrDouble: Codable {
    
    case string(String)
    case double(Double)
    
    init(from decoder: Decoder) throws {
        if let double = try? decoder.singleValueContainer().decode(Double.self) {
            self = .double(double)
            return
        }
        if let string = try? decoder.singleValueContainer().decode(String.self) {
            self = .string(string)
            return
        }
        throw Error.couldNotFindStringOrDouble
    }
    enum Error: Swift.Error {
        case couldNotFindStringOrDouble
    }
}
