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
    //  @Published var movies : [Movie] = []
    
    /// variable that hold the data of state, by default the data is loading
    @Published var state : State = .loading
    
    /// `enum`: way to define possible state of data/action that is mutuallly exclusive. It only can be define one each when use it and could not define multiple at same time. It also can hold value.
    ///  enum state that indicate status of the data
    enum State {
        case loading
        case loaded(movies : [Movie])
        case error(error : Error)
    }
    
    func loadMovies() async {
        do {
            /// movies = try await service.getMoviesFromAPI()
            
            let movies = try await service.getMoviesFromAPI()
            /// assign movies data to state variable with loaded case if the network call success
            state = .loaded(movies: movies)
        } catch {
            /// assign error to state variable with error case if it occurs and let View know it need to deal with it
            state = .error(error: error)
            print(error.localizedDescription)
        }
    }
}
