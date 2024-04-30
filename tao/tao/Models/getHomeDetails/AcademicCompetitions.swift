/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct AcademicCompetitions : Codable {
	let rewardType : String?
	let entryFee : Int?
	let status : String?
	let participationCount : Int?
	let maxAge : Int?
	let rewardRuleId : String?
	let createdTimeStamp : String?
	let background : String?
	let endTime : String?
	let activity : Bool?
	let name : String?
	let priority : Int?
	let prize : Int?
	let imageUrl : String?
	let id : String?
	let questionCriteria : QuestionCriteria?
	let paid : Bool?
	let participationCloseTime : String?
	let subCategory : String?
	let minParticipants : Int?
	let contentMaxDuration : Int?
	let minAge : Int?
	let certificateGenerated : Bool?
	let maxParticipants : Int?
	let standards : [Int]?
	let sample : String?
	let mediaType : String?
	let startTime : String?
	let guide : [Guide]?
	let evaluationDetails : EvaluationDetails?
	let categoryType : String?
	let description : String?
    let categoryImage: String?

//	enum CodingKeys: String, CodingKey {
//
//		case rewardType = "rewardType"
//		case entryFee = "entryFee"
//		case status = "status"
//		case participationCount = "participationCount"
//		case maxAge = "maxAge"
//		case rewardRuleId = "rewardRuleId"
//		case createdTimeStamp = "createdTimeStamp"
//		case background = "background"
//		case endTime = "endTime"
//		case activity = "activity"
//		case name = "name"
//		case priority = "priority"
//		case prize = "prize"
//		case imageUrl = "imageUrl"
//		case id = "id"
//		case questionCriteria = "questionCriteria"
//		case paid = "paid"
//		case participationCloseTime = "participationCloseTime"
//		case subCategory = "subCategory"
//		case minParticipants = "minParticipants"
//		case contentMaxDuration = "contentMaxDuration"
//		case minAge = "minAge"
//		case certificateGenerated = "certificateGenerated"
//		case maxParticipants = "maxParticipants"
//		case standards = "standards"
//		case sample = "sample"
//		case mediaType = "mediaType"
//		case startTime = "startTime"
//		case guide = "guide"
//		case evaluationDetails = "evaluationDetails"
//		case categoryType = "categoryType"
//		case description = "description"
//	}
//
//	init(from decoder: Decoder) throws {
//		let values = try decoder.container(keyedBy: CodingKeys.self)
//		rewardType = try values.decodeIfPresent(String.self, forKey: .rewardType)
//		entryFee = try values.decodeIfPresent(Int.self, forKey: .entryFee)
//		status = try values.decodeIfPresent(String.self, forKey: .status)
//		participationCount = try values.decodeIfPresent(Int.self, forKey: .participationCount)
//		maxAge = try values.decodeIfPresent(Int.self, forKey: .maxAge)
//		rewardRuleId = try values.decodeIfPresent(String.self, forKey: .rewardRuleId)
//		createdTimeStamp = try values.decodeIfPresent(String.self, forKey: .createdTimeStamp)
//		background = try values.decodeIfPresent(String.self, forKey: .background)
//		endTime = try values.decodeIfPresent(String.self, forKey: .endTime)
//		activity = try values.decodeIfPresent(Bool.self, forKey: .activity)
//		name = try values.decodeIfPresent(String.self, forKey: .name)
//		priority = try values.decodeIfPresent(Int.self, forKey: .priority)
//		prize = try values.decodeIfPresent(Int.self, forKey: .prize)
//		imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
//		id = try values.decodeIfPresent(String.self, forKey: .id)
//		questionCriteria = try values.decodeIfPresent(QuestionCriteria.self, forKey: .questionCriteria)
//		paid = try values.decodeIfPresent(Bool.self, forKey: .paid)
//		participationCloseTime = try values.decodeIfPresent(String.self, forKey: .participationCloseTime)
//		subCategory = try values.decodeIfPresent(String.self, forKey: .subCategory)
//		minParticipants = try values.decodeIfPresent(Int.self, forKey: .minParticipants)
//		contentMaxDuration = try values.decodeIfPresent(Int.self, forKey: .contentMaxDuration)
//		minAge = try values.decodeIfPresent(Int.self, forKey: .minAge)
//		certificateGenerated = try values.decodeIfPresent(Bool.self, forKey: .certificateGenerated)
//		maxParticipants = try values.decodeIfPresent(Int.self, forKey: .maxParticipants)
//		standards = try values.decodeIfPresent([Int].self, forKey: .standards)
//		sample = try values.decodeIfPresent(String.self, forKey: .sample)
//		mediaType = try values.decodeIfPresent(String.self, forKey: .mediaType)
//		startTime = try values.decodeIfPresent(String.self, forKey: .startTime)
//		guide = try values.decodeIfPresent([Guide].self, forKey: .guide)
//		evaluationDetails = try values.decodeIfPresent(EvaluationDetails.self, forKey: .evaluationDetails)
//		categoryType = try values.decodeIfPresent(String.self, forKey: .categoryType)
//		description = try values.decodeIfPresent(String.self, forKey: .description)
//	}

}
