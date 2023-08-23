import Foundation

struct MoviesResponse: Decodable {
  
  let results: [Movie]
  let totalResults: Int
  
  enum CodingKeys: String, CodingKey {
    case results
    case totalResults
  }
  
}
