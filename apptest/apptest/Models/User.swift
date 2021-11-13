import Foundation

struct User: Codable, Identifiable {
    var id: Int? = nil
    var name: String? = nil
    var email: String? = nil
    var phone: String? = nil
}
