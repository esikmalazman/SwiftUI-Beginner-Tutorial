//
//  MovieViewModel.swift
//  MovieAppTutorial-Vincent
//
//  Created by Ikmal Azman on 28/01/2023.
//

import Foundation

/// `@MainActor` : let compiler know any code from async await that update the property it should update in the main thread
/// `ObservableObject`: protocol to allow SwiftUI know if the state in viewModel change, the View need to update
@MainActor
final class MovieViewModel : ObservableObject {
    
    let service = MovieService()
    
    /// `Published`: Combine Property Wrapper, allow to let SwiftUI know if it change the view need to update
    @Published var movies : [Movie] = []
    
    
    func loadMovies() async {
        do {
            movies = try await service.getMoviesFromAPI()
        } catch {
            print(error.localizedDescription)
        }
    }
}
