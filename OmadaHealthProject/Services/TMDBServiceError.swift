import Foundation

enum TMDBServiceError: Error {
  case decoding
  case badURL
  case invalidResponse
}

extension TMDBServiceError: CustomStringConvertible {
  var description: String {
    switch self {
    case .decoding:
      return "There was an error decoding the data"
    case .badURL:
      return "Bad URL request"
    case .invalidResponse:
      return "Received invalid response from API"
    }
  }
}
