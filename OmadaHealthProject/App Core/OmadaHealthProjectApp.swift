import SwiftUI

@main
struct OmadaHealthProjectApp: App {
  
  var body: some Scene {
    WindowGroup {
      makeSearchView()
    }
  }
  
  private func makeSearchView() -> MovieSearchView {
    let tmdbService = TMDBService.live
    let viewModel = MovieSearchViewModel(movieService: tmdbService)
    return MovieSearchView(viewModel: viewModel)
  }
  
}
