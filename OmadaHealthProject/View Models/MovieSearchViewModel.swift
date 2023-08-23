import Combine
import Foundation

final class MovieSearchViewModel: ObservableObject {
  
  let movieService: TMDBService
  
  @Published var searchText = ""
  @Published private(set) var movies: [Movie] = []
  private var cancellables = Set<AnyCancellable>()
  
  init(movieService: TMDBService) {
    self.movieService = movieService
    debounceTextChanges()
  }
  
  func debounceTextChanges() {
    $searchText
      .dropFirst()
      .debounce(for: 0.5, scheduler: DispatchQueue.main)
      .sink { value in
        self.loadMovies()
      }
      .store(in: &cancellables)
  }
  
  func loadMovies() {
    movieService.getMovies(for: searchText) { movies in
      DispatchQueue.main.async {
        self.movies = movies?.results ?? []
      }
    }
  }
  
}
