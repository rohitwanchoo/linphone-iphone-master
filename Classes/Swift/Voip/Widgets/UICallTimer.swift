/*
 * Copyright (c) 2010-2020 Belledonne Communications SARL.
 *
 * This file is part of linphone-iphone
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

import Foundation
import linphonesw

class CallTimer : StyledLabel  {
	
	let min_width = 50.0
	
	let formatter = DateComponentsFormatter()
	var startDate = Date()
	var call:Call? = nil {
		didSet {
			self.format()
		}
	}
	
	var conference:Conference? = nil {
		didSet {
			self.format()
		}
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	init (_ text:String?, _ style:TextStyle, _ call:Call? = nil) {
		super.init(style,text)
		self.call = call
		formatter.unitsStyle = .positional
		formatter.allowedUnits = [.minute, .second ]
		formatter.zeroFormattingBehavior = [ .pad ]
		Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
			var elapsedTime: TimeInterval = 0
			if (self.call != nil || self.conference != nil) {
				elapsedTime = Date().timeIntervalSince(self.startDate)
			}
			self.formatter.string(from: elapsedTime).map {
				self.text = $0.hasPrefix("0:") ? "0" + $0 : $0
			}
		}
		minWidth(min_width).done()

	}

	
	func format() {
		guard let duration = self.call != nil ? self.call!.duration : self.conference != nil ? self.conference!.duration: nil else {
			return
		}
		startDate = Date().advanced(by: -TimeInterval(duration))
	}
}
