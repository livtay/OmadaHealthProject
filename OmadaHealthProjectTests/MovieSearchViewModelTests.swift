import XCTest
@testable import OmadaHealthProject

final class MovieSearchViewModelTests: XCTestCase {

  func test_init() {
    let movieService = TMDBService.live
    let sut = MovieSearchViewModel(movieService: movieService)
    XCTAssertNotNil(sut)
  }
  
}
