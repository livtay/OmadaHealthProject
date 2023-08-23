import SwiftUI

@main
struct OmadaHealthProjectApp: App {
  
  var body: some Scene {
    WindowGroup {
      MovieSearchView(viewModel: MovieSearchViewModel(movieService: TMDBService()))
    }
  }
  
}
