//
//  2025 Cristiano Galiano UIDesign Sample
//

import UIKit

extension UIControl {
	func simulate(event: UIControl.Event) {
		allTargets.forEach { target in
			actions(forTarget: target, forControlEvent: event)?.forEach {
				(target as NSObject).perform(Selector($0))
			}
		}
	}
}
