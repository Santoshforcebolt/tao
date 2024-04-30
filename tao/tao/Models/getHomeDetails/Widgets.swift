/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Widgets : Codable {
	let id : String?
	let subText : String?
	let screenType : String?
	let active : Bool?
	let link : String?
	let priority : Int?
	let type : String?
	let cta : String?
	let imageUrl : String?
	let background : String?
	let audienceIds : [Int]?
	let text : String?
	let minAppVersion : Int?
	let maxAppVersion : Int?
	let name : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case subText = "subText"
		case screenType = "screenType"
		case active = "active"
		case link = "link"
		case priority = "priority"
		case type = "type"
		case cta = "cta"
		case imageUrl = "imageUrl"
		case background = "background"
		case audienceIds = "audienceIds"
		case text = "text"
		case minAppVersion = "minAppVersion"
		case maxAppVersion = "maxAppVersion"
		case name = "name"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		subText = try values.decodeIfPresent(String.self, forKey: .subText)
		screenType = try values.decodeIfPresent(String.self, forKey: .screenType)
		active = try values.decodeIfPresent(Bool.self, forKey: .active)
		link = try values.decodeIfPresent(String.self, forKey: .link)
		priority = try values.decodeIfPresent(Int.self, forKey: .priority)
		type = try values.decodeIfPresent(String.self, forKey: .type)
		cta = try values.decodeIfPresent(String.self, forKey: .cta)
		imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
		background = try values.decodeIfPresent(String.self, forKey: .background)
		audienceIds = try values.decodeIfPresent([Int].self, forKey: .audienceIds)
		text = try values.decodeIfPresent(String.self, forKey: .text)
		minAppVersion = try values.decodeIfPresent(Int.self, forKey: .minAppVersion)
		maxAppVersion = try values.decodeIfPresent(Int.self, forKey: .maxAppVersion)
		name = try values.decodeIfPresent(String.self, forKey: .name)
	}

}