//
//  Buinder.swift
//  DialCountries
//
//  Created by Ahmad Almasri on 6/7/20.
//

import Foundation

final class BundleLoader {
	
	static func getBundle() -> Bundle {
		let bundle = Bundle(for: BundleLoader.self)

		return bundle
		
	}
}
