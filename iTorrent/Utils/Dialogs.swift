//
//  UpdatesDialog.swift
//  iTorrent
//
//  Created by Daniil Vinogradov on 21/08/2018.
//  Copyright © 2018  XITRIX. All rights reserved.
//

import Foundation
import UIKit

class Dialogs {
    static func crateUpdateDialog(forced: Bool = false, finishAction: (()->())? = nil) -> ThemedUIAlertController? {
		let localurl = Bundle.main.url(forResource: "Version", withExtension: "ver")
		if let localVersion = try? String(contentsOf: localurl!) {
            if (!UserPreferences.versionNews.value || forced) {
				let title = localVersion + NSLocalizedString("info", comment: "")
				let newsController = ThemedUIAlertController(title: title.replacingOccurrences(of: "\n", with: ""), message: NSLocalizedString("UpdateText", comment: ""), preferredStyle: .alert)
				let close = UIAlertAction(title: NSLocalizedString("Close", comment: ""), style: .cancel) { _ in
					UserPreferences.versionNews.value = true
                    finishAction?()
				}
				newsController.addAction(close)
				return newsController
			}
		}
        finishAction?()
		return nil
	}
    
    static func createNewsDialog() -> ThemedUIAlertController? {
        if #available(iOS 13, *) {
            let code = "0"
            if (!UserPreferences.alertDialog(code: code).value) {
                let newsController = ThemedUIAlertController(title: Localize.get("Dialogs.News.Title"), message: Localize.get("Dialogs.News.Message"), preferredStyle: .alert)
                let close = UIAlertAction(title: Localize.get("Close"), style: .cancel) { _ in
                    UserPreferences.alertDialog(code: code).value = true
                }
                newsController.addAction(close)
                return newsController
            }
        }
        return nil
    }
}
