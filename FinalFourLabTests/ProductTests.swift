//
//  ProductTests.swift
//  FinalFourLabTests
//
//  Created by aarthur on 8/1/21.
//

import XCTest
@testable import FinalFourLab

enum TestCase: Int {
    case full = 0
    case noAuthor
    case noImage
    case onlyTitle
}

class ProductTests: XCTestCase {
    lazy var mockProducts: [[Product]]? = { return parse(named: "MockProducts", bundle: Bundle(for: ProductTests.self)) }()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func parse(named name: String, bundle: Bundle) -> [[Product]]? {
        guard let url = bundle.url(forResource: name, withExtension: "json") else { return .none }
        guard let configData = try? Data(contentsOf: url) else { return .none }
        guard let response = try? JSONDecoder().decode([[Product]].self, from: configData) else { return .none }
        return response
    }

    func testFull() {
        guard let products = mockProducts?[TestCase.full.rawValue] else { XCTFail("No test data"); return }
        let product = products[0]
        XCTAssertEqual(product.title, "title")
        XCTAssertEqual(product.author, "author")
        XCTAssertEqual(product.imageURL?.absoluteString, "https://www.finalfour.com")
    }
    
    func testNoAuthor() {
        guard let products = mockProducts?[TestCase.noAuthor.rawValue] else { XCTFail("No test data"); return }
        let product = products[0]
        XCTAssertEqual(product.title, "title")
        XCTAssertNil(product.author)
    }
    
    func testNoImage() {
        guard let products = mockProducts?[TestCase.noImage.rawValue] else { XCTFail("No test data"); return }
        let product = products[0]
        XCTAssertEqual(product.title, "title")
        XCTAssertNil(product.imageURL)
    }
    
    func testTitleOnly() {
        guard let products = mockProducts?[TestCase.onlyTitle.rawValue] else { XCTFail("No test data"); return }
        let product = products[0]
        XCTAssertEqual(product.title, "title")
        XCTAssertNil(product.author)
        XCTAssertNil(product.imageURL)
    }
}
