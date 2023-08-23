import Foundation

struct TMDBService {
  
  private let apiKey = "b11fc621b3f7f739cb79b50319915f1d"
  
  /// Creates a URL request for a search query and decodes to Movies Response
  /// - Parameter query: string to search
  /// - Parameter page: page of results to return, default 1
  /// - Parameter completion: completion handler that returns the response
  func getMovies(for query: String, page: Int = 1, completion: @escaping (MoviesResponse?) -> Void) async throws {
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "api.themoviedb.org"
    urlComponents.path = "/3/search/movie"
    let queryItems: [URLQueryItem] = [
      URLQueryItem(name: "api_key", value: apiKey),
      URLQueryItem(name: "query", value: query),
      URLQueryItem(name: "page", value: String(page)),
      URLQueryItem(name: "include_adult", value: "false")
    ]
    urlComponents.queryItems = queryItems
    
    if let url = urlComponents.url {
      let (data, _) = try await URLSession.shared.data(from: url)
      let decoder = JSONDecoder()
      decoder.keyDecodingStrategy = .convertFromSnakeCase
      do {
        let movies = try decoder.decode(MoviesResponse.self, from: data)
        completion(movies)
      } catch {
        throw TMDBServiceError.decoding
      }
      return
    } else {
      throw TMDBServiceError.badURL
    }
  }
  
}
