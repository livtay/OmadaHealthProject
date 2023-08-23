import SwiftUI

struct MovieDetailsView: View {
  var movie: Movie
  
  // MARK: - Views
  
  var body: some View {
    ScrollView {
      VStack {
        movieDetailsHeaderView
        movieOverviewView
        Spacer()
      }
    }
  }
  
  @ViewBuilder private var movieDetailsHeaderView: some View {
    HStack(alignment: .top) {
      AsyncImage(
        url: URL(string: movie.imageURL),
        content: { image in
          image
            .resizable()
            .scaledToFill()
            .frame(width: 75, height: 100)
            .clipped()
        }, placeholder: {
          Image(systemName: "popcorn")
            .renderingMode(.template)
            .resizable()
            .scaledToFit()
            .frame(width: 75, height: 100)
            .foregroundColor(Color(.systemGray3))
        }
      )
      VStack(alignment: .leading) {
        Text(movie.title)
          .font(.title3.weight(.bold))
        Text(movie.formattedDate)
          .font(.callout)
          .foregroundColor(Color(.systemGray))
          .fixedSize(horizontal: false, vertical: true)
        Spacer()
        ratingView
      }
      .frame(height: 100)
      .multilineTextAlignment(.leading)
      Spacer()
    }
    .padding()
    .frame(height: 100)
    Divider()
      .padding(.leading)
  }
  
  @ViewBuilder private var ratingView: some View {
    if let avg = movie.voteAverage {
      let avgString = String(format: "%.1f", avg)
      VStack(alignment: .leading, spacing: 2) {
        Text("Viewer Rating")
          .font(.caption.weight(.medium))
          .foregroundColor(Color(.systemGray))
        Text("\(avgString)/10")
          .font(.headline)
        ProgressView(value: avg, total: 10.0)
      }
    }
  }
  
  @ViewBuilder private var movieOverviewView: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text("OVERVIEW")
        .font(.headline)
        .foregroundColor(Color(.darkGray))
        .fixedSize(horizontal: false, vertical: true)
        .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
      Text(movie.overview)
        .font(.subheadline)
        .fixedSize(horizontal: false, vertical: true)
        .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
      Divider()
    }
    .padding(.horizontal)
  }
  
}

// MARK: - Preview provider

struct MovieDetailsView_Previews: PreviewProvider {
  static var previews: some View {
    MovieDetailsView(
      movie: Movie(
        id: 1,
        title: "Test Movie",
        overview: "Test movie with a really long overview that takes up multiple lines of the text.",
        releaseDate: "1993-06-17",
        posterPath: "lkoI9rc3OhuSYSy7gK45a3Nk9HH.jpg",
        voteAverage: 8.3
      )
    )
  }
}
