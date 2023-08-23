import SwiftUI

struct MovieRow: View {
  var movie: Movie
  
  // MARK: - View
  
  var body: some View {
    VStack {
      HStack(alignment: .top, spacing: 16) {
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
        VStack(alignment: .leading, spacing: 2) {
          Text(movie.title)
            .font(.title3.weight(.bold))
            .fixedSize(horizontal: false, vertical: true)
            .lineLimit(3)
          Text(movie.releaseYear)
            .font(.callout)
            .foregroundColor(Color(.systemGray))
            .fixedSize(horizontal: false, vertical: true)
          Spacer()
        }
        .multilineTextAlignment(.leading)
        Spacer()
      }
      .padding()
      .frame(height: 100)
      Divider()
        .padding(.leading)
    }
  }
  
}

// MARK: - Preview provider

struct MovieRow_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      MovieRow(
        movie: Movie(
          id: 1,
          title: "Test Movie",
          overview: "",
          releaseDate: "1993-06-17",
          posterPath: "lkoI9rc3OhuSYSy7gK45a3Nk9HH.jpg",
          voteAverage: 5.7
        )
      )
      MovieRow(
        movie: Movie(
          id: 2,
          title: "No Image",
          overview: "",
          releaseDate: "2023-01-01",
          posterPath: "",
          voteAverage: 5.7
        )
      )
      MovieRow(
        movie: Movie(
          id: 1,
          title: "Test Movie With a Really Long Title That Takes Up Multiple Lines of the Title Text",
          overview: "",
          releaseDate: "1993-06-17",
          posterPath: "lkoI9rc3OhuSYSy7gK45a3Nk9HH.jpg",
          voteAverage: nil
        )
      )
    }
  }
}
