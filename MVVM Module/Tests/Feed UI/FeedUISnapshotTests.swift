//
//  2025 Cristiano Galiano UIDesign Sample
//

import XCTest
import FeedFeature
@testable import MVVM

class FeedUISnapshotTests: XCTestCase {
	//  ***********************
	//
	//  [DO NOT DELETE THIS COMMENT]
	//
	//  Uncomment and run one test at a time
	//  to validate the layout (including Dark Mode support).
	//
	//  ***********************

	func test_emptyFeed() {
		let sut = makeSUT()

		sut.display(emptyFeed())

		assert(snapshot: sut.snapshot(for: .iPhone(style: .light)), named: "EMPTY_FEED_light")
		assert(snapshot: sut.snapshot(for: .iPhone(style: .dark)), named: "EMPTY_FEED_dark")
	}

	func test_feedWithError() {
		let sut = makeSUT()

		sut.display(errorMessage: "An error message")

		assert(snapshot: sut.snapshot(for: .iPhone(style: .light)), named: "FEED_WITH_ERROR_light")
		assert(snapshot: sut.snapshot(for: .iPhone(style: .dark)), named: "FEED_WITH_ERROR_dark")
	}

	// MARK: - Helpers

	private func makeSUT() -> FeedViewController {
		let bundle = Bundle(for: FeedViewController.self)
		let storyboard = UIStoryboard(name: "Feed", bundle: bundle)
		let controller = storyboard.instantiateInitialViewController() as! FeedViewController
		controller.viewModel = FeedViewModel(feedLoader: AlwaysSucceedingFeedLoader())
		controller.simulateAppearance()
		controller.tableView.showsVerticalScrollIndicator = false
		controller.tableView.showsHorizontalScrollIndicator = false
		return controller
	}

	private func emptyFeed() -> [FeedImageCellController] {
		[]
	}
}

private class AlwaysSucceedingFeedLoader: FeedLoader {
	func load(completion: @escaping (FeedLoader.Result) -> Void) {
		completion(.success([]))
	}
}

private extension FeedViewController {
	func display(errorMessage: String) {
		errorView?.show(message: errorMessage)
	}

	func display(_ feed: [FeedImageCellController]) {
		tableModel = feed
	}
}
