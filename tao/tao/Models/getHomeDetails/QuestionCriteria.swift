/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct QuestionCriteria : Codable {
	let topics : [String]?
	let considerUserStandard : Bool?
	let standard : String?
	let difficultyLevelSplit : DifficultyLevelSplit?
	let subject : String?
	let type : String?
	let numQuestions : Int?
	let tags : [String]?

	enum CodingKeys: String, CodingKey {

		case topics = "topics"
		case considerUserStandard = "considerUserStandard"
		case standard = "standard"
		case difficultyLevelSplit = "difficultyLevelSplit"
		case subject = "subject"
		case type = "type"
		case numQuestions = "numQuestions"
		case tags = "tags"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		topics = try values.decodeIfPresent([String].self, forKey: .topics)
		considerUserStandard = try values.decodeIfPresent(Bool.self, forKey: .considerUserStandard)
		standard = try values.decodeIfPresent(String.self, forKey: .standard)
		difficultyLevelSplit = try values.decodeIfPresent(DifficultyLevelSplit.self, forKey: .difficultyLevelSplit)
		subject = try values.decodeIfPresent(String.self, forKey: .subject)
		type = try values.decodeIfPresent(String.self, forKey: .type)
		numQuestions = try values.decodeIfPresent(Int.self, forKey: .numQuestions)
		tags = try values.decodeIfPresent([String].self, forKey: .tags)
	}

}