//
//  Constants.swift
//  tao
//
//  Created by Betto Akkara on 03/02/22.
//

import Foundation

public class Constant {

    public static var shared = Constant()

    var errorStrings : ErrorStrings?

    struct ErrorStrings {
        let try_later = "Sorry we encountered a problem, try after sometime!!!"
    }

}
