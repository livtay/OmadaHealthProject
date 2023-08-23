import Foundation

struct Movie: Decodable, Equatable, Hashable, Identifiable {
  
  let id: Int
  let title: String
  let overview: String
  let releaseDate: String
  let posterPath: String?
  let voteAverage: Double?
  
  enum CodingKeys: String, CodingKey {
    case id, title, overview
    case releaseDate
    case posterPath
    case voteAverage
  }
  
  var formattedDate: String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    if let date = dateFormatter.date(from: releaseDate) {
      dateFormatter.dateFormat = "MMMM d, yyyy"
      return dateFormatter.string(from: date)
    } else {
      return releaseDate
    }
  }

  var releaseYear: String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    guard let date = dateFormatter.date(from: releaseDate),
          let year = Calendar.current.dateComponents([.year], from: date).year else {
      return ""
    }
    return String(year)
  }
  
  var imageURL: String {
    return "https://image.tmdb.org/t/p/original/\(posterPath ?? "")"
  }
  
}
