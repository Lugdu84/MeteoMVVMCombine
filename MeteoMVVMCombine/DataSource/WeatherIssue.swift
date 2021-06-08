//
//  WeatherIssue.swift
//  MeteoMVVMCombine
//
//  Created by David Grammatico on 05/06/2021.
//

import Foundation


enum WeatherIssue: Error {
    case json(desc: String)
    case connexion(desc: String)
}
