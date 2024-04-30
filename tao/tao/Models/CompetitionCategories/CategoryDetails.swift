/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct CategoryDetails : Codable {
	let category : String?
	let backgroundColor : String?
	let id : String?
	let imageUrl : String?
	let subCategory : String?
	let description : String?
	let priority : Int?
	let competitionCount : Int?

	enum CodingKeys: String, CodingKey {

		case category = "category"
		case backgroundColor = "backgroundColor"
		case id = "id"
		case imageUrl = "imageUrl"
		case subCategory = "subCategory"
		case description = "description"
		case priority = "priority"
		case competitionCount = "competitionCount"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		category = try values.decodeIfPresent(String.self, forKey: .category)
		backgroundColor = try values.decodeIfPresent(String.self, forKey: .backgroundColor)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
		subCategory = try values.decodeIfPresent(String.self, forKey: .subCategory)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		priority = try values.decodeIfPresent(Int.self, forKey: .priority)
		competitionCount = try values.decodeIfPresent(Int.self, forKey: .competitionCount)
	}

}
