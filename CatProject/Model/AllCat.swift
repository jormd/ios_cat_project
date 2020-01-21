// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let allCat = try? newJSONDecoder().decode(AllCat.self, from: jsonData)

import Foundation
import UIKit

// MARK: - AllCat
class AllCat: Codable {
    var all: [Cat]?

    init(all: [Cat]?) {
        self.all = all
    }
}
