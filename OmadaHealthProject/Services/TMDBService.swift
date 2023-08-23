import Foundation

class TMDBService {
  
  private let apiKey = "b11fc621b3f7f739cb79b50319915f1d"
  
  func getMovies(for query: String, page: Int = 1, completion: @escaping (MoviesResponse?) -> Void) {
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
      let urlRequest = URLRequest(url: url)
      URLSession.shared.dataTask(with: urlRequest, completionHandler: { data, response, error in
        guard let data = data else {
          completion(nil)
          return
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let movies = try? decoder.decode(MoviesResponse.self, from: data)
        completion(movies)
      })
      .resume()
    }
    // TODO: handle error
  }
  
}
