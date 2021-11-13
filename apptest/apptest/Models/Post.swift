import Foundation

struct Post: Codable, Identifiable {
    var id: Int? = nil
    var title: String? = nil
    var body: String? = nil
}
