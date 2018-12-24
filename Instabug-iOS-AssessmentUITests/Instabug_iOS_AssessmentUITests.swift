//
//  Instabug_iOS_AssessmentUITests.swift
//  Instabug-iOS-AssessmentUITests
//
//  Created by ahmed mahdy on 12/21/18.
//  Copyright © 2018 ahmed mahdy. All rights reserved.
//

import XCTest

class Instabug_iOS_AssessmentUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
        XCUIApplication().launch()

    }
    func testAddMovies() {
        let app = XCUIApplication()
        app/*@START_MENU_TOKEN@*/.segmentedControls.buttons["My Movies"]/*[[".segmentedControls.buttons[\"My Movies\"]",".buttons[\"My Movies\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/.tap()
        app.tables["Empty list"].buttons["+"].tap()
        let titleTextField = app.textFields["Title"]
        titleTextField.tap()
        titleTextField.typeText("Movie 1")
        let dateTextField = app.textFields["Date"]
        dateTextField.tap()
        dateTextField.typeText("12-12-2018")
        
        let overViewtextView = app.textViews.matching(identifier: "overview").element
        overViewtextView.tap()
        overViewtextView.typeText("This is the first movie overview")
       
        app.buttons["Done"].tap()
        XCTAssert(app.tables.cells.staticTexts["This is the first movie overview"].exists && app.tables.cells.staticTexts["Movie 1"].exists && app.tables.cells.staticTexts["12-12-2018"].exists)
        
    }
    func testMoviesTable(){
        let app = XCUIApplication()
        app/*@START_MENU_TOKEN@*/.segmentedControls.buttons["My Movies"]/*[[".segmentedControls.buttons[\"My Movies\"]",".buttons[\"My Movies\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/.tap()
        XCTAssert(app/*@START_MENU_TOKEN@*/.segmentedControls.buttons["My Movies"]/*[[".segmentedControls.buttons[\"My Movies\"]",".buttons[\"My Movies\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/.exists && app.tables["Empty list"].buttons["+"].exists)
    }
    func testCancellAddMovies() {
        
        let app = XCUIApplication()
        app/*@START_MENU_TOKEN@*/.segmentedControls.buttons["My Movies"]/*[[".segmentedControls.buttons[\"My Movies\"]",".buttons[\"My Movies\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/.tap()
        app.tables["Empty list"].buttons["+"].tap()
        let titleTextField = app.textFields["Title"]
        titleTextField.tap()
        titleTextField.typeText("Movie 1")
        let dateTextField = app.textFields["Date"]
        dateTextField.tap()
        dateTextField.typeText("12-12-2018")
        
        let overViewtextView = app.textViews.matching(identifier: "overview").element
        overViewtextView.tap()
        overViewtextView.typeText("This is the first movie overview")
        
        app.buttons["Cancel"].tap()
        XCTAssert(!app.tables.cells.staticTexts["This is the first movie overview"].exists && !app.tables.cells.staticTexts["Movie 1"].exists && !app.tables.cells.staticTexts["12-12-2018"].exists)
        
    }
    func testAddMoreMovies() {
        let app = XCUIApplication()
        app/*@START_MENU_TOKEN@*/.segmentedControls.buttons["My Movies"]/*[[".segmentedControls.buttons[\"My Movies\"]",".buttons[\"My Movies\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/.tap()
        let tablesQuery = app.tables
        for i in 1...5 {
            tablesQuery.buttons["+"].tap()
            let titleTextField = app.textFields["Title"]
            titleTextField.tap()
            titleTextField.typeText("Movie \(i)")
            let dateTextField = app.textFields["Date"]
            dateTextField.tap()
            dateTextField.typeText("\(i)-12-2018")
            
            let overViewtextView = app.textViews.matching(identifier: "overview").element
            overViewtextView.tap()
            overViewtextView.typeText("This is movie \(i) overview")
            
            app.buttons["Done"].tap()
            app.swipeUp()
            
        }
        let lastCell = tablesQuery.children(matching: .cell).staticTexts["This is movie 5 overview"].firstMatch
        XCTAssert(lastCell.exists && lastCell.isHittable)
    }
    func testMoreLoadedMovies(){
        let app = XCUIApplication()
        let tablesQuery = app.tables
        let lastRow: Int = tablesQuery.numberOfRows(inSection: 0) - 1
        XCTAssert(tablesQuery.children(matching: .cell).count > 0)
    }
    
    let indexPath = IndexPath(row: lastRow, section: 0);
    self.tableview.scrollToRow(at: indexPath, at: .top, animated: false)
}
