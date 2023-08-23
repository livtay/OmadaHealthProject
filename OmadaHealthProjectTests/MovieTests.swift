import XCTest
@testable import OmadaHealthProject

final class MovieTests: XCTestCase {

  func test_dateFormatter() {
    let movie = Movie(
      id: 0,
      title: "Harry Potter",
      overview: "The boy who lived",
      releaseDate: "2001-11-16",
      posterPath: "",
      voteAverage: 7.9
    )
    let expectedDate = "November 16, 2001"
    XCTAssertEqual(expectedDate, movie.formattedDate)
  }
  
  func test_releaseYear() {
    let movie = Movie(
      id: 0,
      title: "Harry Potter",
      overview: "The boy who lived",
      releaseDate: "2001-11-16",
      posterPath: "testPath",
      voteAverage: 7.9
    )
    let expectedYear = "2001"
    XCTAssertEqual(expectedYear, movie.releaseYear)
  }
  
  func test_imageURL() {
    let movie = Movie(
      id: 0,
      title: "Harry Potter",
      overview: "The boy who lived",
      releaseDate: "2001-11-16",
      posterPath: "testPath",
      voteAverage: 7.9
    )
    let expectedUrl = "https://image.tmdb.org/t/p/original/testPath"
    XCTAssertEqual(expectedUrl, movie.imageURL)
  }

}
