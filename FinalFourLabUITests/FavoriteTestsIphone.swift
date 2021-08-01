//
//  FavoriteTestsIphone.swift
//  FinalFourLabUITests
//
//  Created by aarthur on 8/1/21.
//

import XCTest

class FavoriteTestsIphone: XCTestCase {

    override func setUpWithError() throws {
        XCUIApplication().launch()
        continueAfterFailure = false
    }

    func testiPhoneFavoritesToggleOn() {
        let app = XCUIApplication()
        let collectionViewsQuery = app.collectionViews
        let element = collectionViewsQuery.children(matching: .cell).element(boundBy: 1).children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element(boundBy: 3)
        element.tap()

        let detailsNavigationBar = app.navigationBars["Details"]
        let button = detailsNavigationBar.children(matching: .button).element(boundBy: 1)
        XCTAssertEqual(button.identifier, "off")
        button.tap()
        XCTAssertEqual(button.identifier, "on")
        
        let productsButton = detailsNavigationBar.buttons["Products"]
        productsButton.tap()
        collectionViewsQuery.children(matching: .cell).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element(boundBy: 3).tap()
        button.tap()
        productsButton.tap()
        element.tap()
        productsButton.tap()
        collectionViewsQuery.children(matching: .cell).element(boundBy: 3).children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element(boundBy: 3).tap()
        productsButton.tap()
    }

    func testiPhoneFavoritesToggleOff() {
        let app = XCUIApplication()
        let element = app.collectionViews.children(matching: .cell).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element(boundBy: 3)
        element.tap()
        
        let detailsNavigationBar = app.navigationBars["Details"]
        detailsNavigationBar.buttons["off"].tap()
        
        let productsButton = detailsNavigationBar.buttons["Products"]
        productsButton.tap()
        element.tap()
        
        var button = detailsNavigationBar.children(matching: .button).element(boundBy: 1)
        XCTAssertEqual(button.identifier, "on")

        detailsNavigationBar.buttons["on"].tap()
        button = detailsNavigationBar.children(matching: .button).element(boundBy: 1)
        XCTAssertEqual(button.identifier, "off")

        productsButton.tap()
    }
}
