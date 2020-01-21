import Foundation
import UIKit

// MARK: - PictureCatElement
class PictureCat: Codable {
    let id: String
    let url: String

    init(id: String, url: String) {
        self.id = id
        self.url = url
    }
}

