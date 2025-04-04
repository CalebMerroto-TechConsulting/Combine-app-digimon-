//
//  digimon_XCappTests.swift
//  digimon XCappTests
//
//  Created by Caleb Merroto on 3/6/25.
//

import XCTest
import Combine
@testable import digimon_app

final class DigimonXCAppTests: XCTestCase {
    var viewModel: ViewModel<Digimon>!
    var search: Search<Digimon>!
    var cancellables: Set<AnyCancellable> = []

    override func setUpWithError() throws {
        super.setUp()
        viewModel = ViewModel<Digimon>(netService: TestNet())
        search = Search<Digimon>()
    }

    override func tearDownWithError() throws {
        viewModel = nil
        search = nil
        cancellables.removeAll()
        super.tearDown()
    }

    func testViewModelInitialization() throws {
        XCTAssertNotNil(viewModel, "ViewModel should not be nil")
    }
    
    @MainActor
    func testViewModelFetchesData() {
        let expectation = XCTestExpectation(description: "fetchData completes")

        viewModel.$data
            .dropFirst()
            .sink { _ in
                XCTAssertFalse(self.viewModel.data.isEmpty, "Data should not be empty")

                let first = self.viewModel.data.first
                let last = self.viewModel.data.last

                XCTAssertNotNil(first, "First item should not be nil")
                XCTAssertNotNil(last, "Last item should not be nil")

                XCTAssertEqual(first?.name, "Koromon")
                XCTAssertEqual(first?.level, "In Training")
                XCTAssertEqual(first?.img, "https://digimon.shadowsmith.com/img/koromon.jpg")

                XCTAssertEqual(last?.name, "Omnimon")
                XCTAssertEqual(last?.level, "Mega")
                XCTAssertEqual(last?.img, "https://digimon.shadowsmith.com/img/omnimon.jpg")

                XCTAssertEqual(self.viewModel.data.count, 209, "Data count should be 209")

                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.fetchData(search, "testData")

        wait(for: [expectation], timeout: 5.0)
    }
    
    @MainActor
    func testViewModelThrowsRightErrors() {
        let expectation = XCTestExpectation(description: "fetchData should return error")

        viewModel.$error
            .dropFirst()
            .sink { _ in
                XCTAssertNotNil(self.viewModel.error, "Error should not be nil")
                XCTAssertEqual(self.viewModel.error?.msg, ".json not found")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.fetchData(search, "")

        wait(for: [expectation], timeout: 5.0)
    }

    @MainActor
    func testDigimonComputedPropertiesGiveRightValues() {
        let expectation = XCTestExpectation(description: "fetchData loads data")

        viewModel.$data
            .dropFirst()
            .sink { _ in
                let first = self.viewModel.data.first
                let last = self.viewModel.data.last

                XCTAssertNotNil(first, "First Digimon should not be nil")
                XCTAssertNotNil(last, "Last Digimon should not be nil")

                XCTAssertEqual(first?.id, first?.name)
                XCTAssertEqual(last?.id, last?.name)
                XCTAssertEqual(first?.str, "Koromon (In Training)")
                XCTAssertEqual(last?.str, "Omnimon (Mega)")

                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.fetchData(search, "digimon")

        wait(for: [expectation], timeout: 5.0)
    }
}
