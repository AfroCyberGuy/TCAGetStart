import Foundation

struct UserModel: Decodable, Equatable {
  let name: String
  let bio: String?
  let publicRepos: Int
  let followers: Int
}

extension UserModel: Identifiable {
  var id: String { name }
}
