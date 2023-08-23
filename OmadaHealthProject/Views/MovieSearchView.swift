import SwiftUI

struct MovieSearchView: View {
  
  @ObservedObject var viewModel: MovieSearchViewModel
  
  // MARK: - Private properties
  
  @State private var showDetailsView = false
  
  // MARK: - Views
  
  var body: some View {
    NavigationStack {
      movieSearchView
        .searchable(text: $viewModel.searchText)
        .navigationTitle("Movie Search")
    }
  }
  
  @ViewBuilder private var movieSearchView: some View {
    switch viewModel.state {
    case .noResults:
      emptyStateView
    case .success(let movies):
      ScrollView {
        VStack {
          ForEach(movies) { movie in
            NavigationLink {
              MovieDetailsView(movie: movie)
                .navigationBarTitleDisplayMode(.inline)
            } label: {
              MovieRow(movie: movie)
            }
            .buttonStyle(PlainButtonStyle())
          }
        }
      }
      .scrollDismissesKeyboard(.immediately)
    case .error(let error):
      errorStateView(error)
    }
  }
  
  private var emptyStateView: some View {
    Text("No results")
      .foregroundColor(Color(.systemGray))
  }
  
  private func errorStateView(_ error: Error) -> some View {
    Text((error as? TMDBServiceError)?.description ?? "Something went wrong")
      .foregroundColor(Color(.systemGray))
  }
  
}

// MARK: - Preview provider

struct MovieSearchView_Previews: PreviewProvider {
  
  static var previews: some View {
    MovieSearchView(viewModel: MovieSearchViewModel(movieService: TMDBService()))
  }
  
}
