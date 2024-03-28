//
//  ProductFetchError.swift
//  DemoEcomerc
//
//  Created by Aleksandar Mitrovic on 12.3.24.
//

import Foundation
enum ProductFetchError : Error{
    case InvalidUrlError
    case FetchError
    case ParseError
}
