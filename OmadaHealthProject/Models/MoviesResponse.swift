import Foundation

struct MoviesResponse: Decodable {
  
  let page: Int
  let results: [Movie]
  let totalPages: Int
  let totalResults: Int
  
  enum CodingKeys: String, CodingKey {
    case page, results
    case totalPages
    case totalResults
  }
  
}
