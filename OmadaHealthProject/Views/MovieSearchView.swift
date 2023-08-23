import SwiftUI

struct MovieSearchView: View {
  
  @ObservedObject var viewModel: MovieSearchViewModel
  
  // MARK: - Private properties
  
  @State private var showDetailsView = false
  
  // MARK: - View
  
  var body: some View {
    NavigationStack {
      movieSearchView
        .searchable(text: $viewModel.searchText)
        .navigationTitle("Movie Search")
    }
  }
  
  @ViewBuilder private var movieSearchView: some View {
    if viewModel.movies.isEmpty {
      emptyStateView
    } else {
      ScrollView {
        VStack {
          ForEach(viewModel.movies) { movie in
            NavigationLink {
              MovieDetailsView(movie: movie)
                .navigationBarTitleDisplayMode(.inline)
            } label: {
              MovieRow(movie: movie)
              // TODO: fetch more pages here
            }
            .buttonStyle(PlainButtonStyle())
          }
        }
      }
      .scrollDismissesKeyboard(.immediately)
    }
  }
  
  private var emptyStateView: some View {
    Text("No results")
      .foregroundColor(Color(.systemGray))
  }
  
}

struct MovieSearchView_Previews: PreviewProvider {
  
  static var previews: some View {
    MovieSearchView(viewModel: MovieSearchViewModel(movieService: TMDBService()))
  }
  
}
