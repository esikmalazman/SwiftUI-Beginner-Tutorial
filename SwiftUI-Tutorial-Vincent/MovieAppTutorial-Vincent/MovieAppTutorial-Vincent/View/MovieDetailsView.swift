//
//  MovieDetailsView.swift
//  MovieAppTutorial-Vincent
//
//  Created by Ikmal Azman on 31/01/2023.
//

import SwiftUI

/// screen of the app that will show movie casts when select an element in the movie list
struct MovieDetailsView: View {
    
    /// movie will be assign during initialization of the View to get the details and it would never change
    let movie : Movie
    
    /// `@State`: SwiftUI property wrapper that allow to mutate value in the View and let SwiftUI to update the View if it detect any data changes
    /// variable that will store collection cast after receive data from network call
    @State var casts : [MovieCastMember] = []
    
    var body: some View {
        List(casts) { cast in
            VStack(alignment: .leading) {
                Text(cast.character)
                Text(cast.name)
                    .font(.caption)
            }
        }
    }
}

struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsView(movie: Movie.mock, casts: [MovieCastMember].mock)
    }
}
