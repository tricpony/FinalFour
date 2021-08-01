//
//  FavoriteTestsIpad.swift
//  FinalFourLabUITests
//
//  Created by aarthur on 8/1/21.
//

import XCTest

class FavoriteTestsIpad: XCTestCase {

    override func setUpWithError() throws {
        XCUIApplication().launch()
        continueAfterFailure = false
    }

    func testiPhoneFavoritesToggleOn() {
        let app = XCUIApplication()
        app.collectionViews.children(matching: .cell).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element(boundBy: 3).tap()
        app.navigationBars["Details"].buttons["off"].tap()
        let button = app.navigationBars["Details"].buttons["on"]
        XCTAssertEqual(button.identifier, "on")
    }
    
    func testiPhoneFavoritesToggleOff() {
        let app = XCUIApplication()
        app.collectionViews.children(matching: .cell).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element(boundBy: 3).tap()
        
        let detailsNavigationBar = app.navigationBars["Details"]
        detailsNavigationBar.buttons["off"].tap()
        var button = detailsNavigationBar.buttons["on"]
        XCTAssertEqual(button.identifier, "on")
        detailsNavigationBar.buttons["on"].tap()
        button = detailsNavigationBar.buttons["off"]
        XCTAssertEqual(button.identifier, "off")
    }
}
