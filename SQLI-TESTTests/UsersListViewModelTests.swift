//
//  UsersListViewModelTests.swift
//  SQLI-TESTTests
//
//  Created by mohamed mernissi on 6/11/2022.
//

import XCTest
import RxSwift
@testable import SQLI_TEST

class UsersListViewModelTests: XCTestCase {

    // MARK: System Under Test
    private var disposeBag: DisposeBag!
    private var viewModel: UsersListViewModelImplementation!
    private var navigationController: UINavigationController!

    // MARK: - Set Up & Tear Down
    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
        navigationController = UINavigationController()
        viewModel = UsersListViewModelImplementation(
            userService: ApiService(),
            coordinator: UsersListCoordinatorImplementation(navigationController: navigationController)
        )
    }

    override func tearDown() {
        disposeBag = nil
        navigationController = nil
        viewModel = nil
        super.tearDown()
    }

    func testWhenInitializedPageNumberIs1() {
        let expectation = XCTestExpectation(description: "Make sure the starting value for pagenumber is 1")

        viewModel.pageNumberObs
            .subscribe(onNext: { (value) in
                XCTAssertEqual(value, 1)

                expectation.fulfill()
            })
            .disposed(by: disposeBag)

        wait(for: [expectation], timeout: 1.0)
    }

    func testWhenScrollsToBottomPageNumberIncreases() {
        let expectation = XCTestExpectation(description: "Pagination incremented after reaching bottom")

        viewModel.didScrollToTheBottom.accept(())

        viewModel.pageNumberObs
            .subscribe(onNext: { (value) in
                XCTAssertEqual(value, 2)

                expectation.fulfill()
            })
            .disposed(by: disposeBag)

        wait(for: [expectation], timeout: 1.0)
    }

}
