//
//  2025 Cristiano Galiano UIDesign Sample
//

import Foundation
import FeedFeature

final class FeedViewModel {
	typealias Observer<T> = (T) -> Void

	private let feedLoader: FeedLoader

	init(feedLoader: FeedLoader) {
		self.feedLoader = feedLoader
	}

	var title: String {
		Localized.Feed.title
	}

	var onLoadingStateChange: Observer<Bool>?
	var onFeedLoad: Observer<[FeedImage]>?
	var onErrorStateChange: Observer<String?>?

	func loadFeed() {
		onLoadingStateChange?(true)
		onErrorStateChange?(.none)

		feedLoader.load { [weak self] result in
			switch result {
			case let .success(feed):
				self?.onFeedLoad?(feed)
			case .failure:
				self?.onErrorStateChange?(Localized.Feed.loadError)
			}
			self?.onLoadingStateChange?(false)
		}
	}
}
