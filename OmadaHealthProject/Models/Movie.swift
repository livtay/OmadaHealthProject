import Foundation

struct Movie: Decodable, Equatable, Hashable, Identifiable {
  
  let id: Int
  let title: String
  let overview: String
  let releaseDate: String
  let posterPath: String?
  let voteAverage: Double?
  
  enum CodingKeys: String, CodingKey {
    case id
    case title
    case overview
    case releaseDate
    case posterPath
    case voteAverage
  }
  
  // Changes date format for details page
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

  // Gets release year from release date
  var releaseYear: String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    guard let date = dateFormatter.date(from: releaseDate),
          let year = Calendar.current.dateComponents([.year], from: date).year else {
      return ""
    }
    return String(year)
  }
  
  // Takes poster path and returns full image URL
  var imageURL: String {
    return "https://image.tmdb.org/t/p/original/\(posterPath ?? "")"
  }
  
}
