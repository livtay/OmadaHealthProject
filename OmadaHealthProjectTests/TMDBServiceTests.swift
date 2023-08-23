import XCTest
@testable import OmadaHealthProject

final class TMDBServiceTests: XCTestCase {

  func testGetMovies_success() async {
    let sut = TMDBService.live
    
    do {
      let movies = try await sut.getMovieList("Ave")
      guard let movies = movies else {
        XCTFail()
        return
      }
      XCTAssertTrue(!movies.results.isEmpty)
    } catch {
      XCTFail()
    }
  }
  
  func testGetMovies_empty() async {
    let sut = TMDBService.live
    
    do {
      let movies = try await sut.getMovieList("")
      guard let movies = movies else {
        XCTFail()
        return
      }
      XCTAssertTrue(movies.results.isEmpty)
    } catch {
      XCTFail()
    }
  }
  
  func testGetMovies_fail() async {
    let sut = TMDBService.fail
    let expectedError = TMDBServiceError.invalidResponse
    
    do {
      let _ = try await sut.getMovieList("")
      XCTFail()
    } catch {
      XCTAssertEqual(error as? TMDBServiceError, expectedError)
    }
  }

}
