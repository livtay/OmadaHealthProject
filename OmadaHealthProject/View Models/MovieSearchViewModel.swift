import Combine
import Foundation

final class MovieSearchViewModel: ObservableObject {
  
  // States of view model to alter the UI
  enum MovieSearchState {
    case noResults
    case success(_ movies: [Movie])
    case error(_ error: Error)
  }
  
  let movieService: TMDBService
  @Published var searchText = ""
  
  // MARK: - Private properties
  
  @Published private(set) var state: MovieSearchState = .noResults
  private var cancellables = Set<AnyCancellable>()
  
  // MARK: - Initializer
  
  init(movieService: TMDBService) {
    self.movieService = movieService
    debounceTextChanges()
  }
  
}

// MARK: - Private functions

private extension MovieSearchViewModel {
  
  func debounceTextChanges() {
    $searchText
      .dropFirst()
      .debounce(for: 0.5, scheduler: DispatchQueue.main)
      .sink { value in
        Task {
          try await self.loadMovies()
        }
      }
      .store(in: &cancellables)
  }
  
  func loadMovies() async throws {
    do {
      let movies = try await movieService.getMovieList(searchText)
      DispatchQueue.main.async {
        let results = movies?.results ?? []
        self.state = results.isEmpty ? .noResults : .success(results)
      }
    } catch let error {
      // Handle the error in the UI by setting the state
      DispatchQueue.main.async {
        self.state = .error(error)
      }
    }
  }
  
}
