import Foundation

struct TMDBService {
  
  /// Creates a URL request for a search query and decodes to Movies Response
  let getMovieList: (String) async throws -> MoviesResponse?
  
}

extension TMDBService {
  
  // live environment for production
  static var live: TMDBService {
    TMDBService(
      getMovieList: { query in
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.themoviedb.org"
        urlComponents.path = "/3/search/movie"
        let queryItems: [URLQueryItem] = [
          URLQueryItem(name: "api_key", value: "b11fc621b3f7f739cb79b50319915f1d"),
          URLQueryItem(name: "query", value: query),
          URLQueryItem(name: "page", value: "1"),
          URLQueryItem(name: "include_adult", value: "false")
        ]
        urlComponents.queryItems = queryItems
        
        if let url = urlComponents.url {
          let (data, _) = try await URLSession.shared.data(from: url)
          let decoder = JSONDecoder()
          decoder.keyDecodingStrategy = .convertFromSnakeCase
          do {
            let movies = try decoder.decode(MoviesResponse.self, from: data)
            return movies
          } catch {
            throw TMDBServiceError.decoding
          }
        } else {
          throw TMDBServiceError.badURL
        }
      }
    )
  }
  
  // failing environment for testing
  static var fail: TMDBService {
    TMDBService(
      getMovieList: { _ in
        throw TMDBServiceError.invalidResponse
      }
    )
  }
  
}
