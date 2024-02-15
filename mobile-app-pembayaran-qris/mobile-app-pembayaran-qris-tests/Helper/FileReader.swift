//
//  FileReader.swift
//  mobile-app-pembayaran-qris-tests
//
//  Created by Muhammad Fachri Nuriza on 15/02/24.
//

import Foundation
import XCTest

final class FileReader {
    static func readJSON(name: String) -> Data? {
        let bundle = Bundle(for: FileReader.self)
        guard let url = bundle.url(forResource: name, withExtension: "json") else { return nil }
        
        do {
            return try Data(contentsOf: url, options: .mappedIfSafe)
        } catch {
            XCTFail("Error occurred parsing test data")
            return nil
        }
    }
}
