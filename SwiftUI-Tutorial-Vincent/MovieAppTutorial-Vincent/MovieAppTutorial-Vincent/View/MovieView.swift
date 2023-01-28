//
//  ContentView.swift
//  MovieAppTutorial-Vincent
//
//  Created by Ikmal Azman on 23/01/2023.
//

import SwiftUI

/// screen of the app
struct MovieView: View {
    
    /// `@StateObject`: tell SwiftUI to listen that this View to listen any changes in this viewModel
    @StateObject var viewModel = MovieViewModel()
    
    var body: some View {
        
        /// List(data:) : SwiftUI built in type that allow to display list of data, it accept collection type like array as input
        /// List handle itself when detect an update in the data by perform necessary computation and animation
        /// List require a way to identify a element so it need an id
        /// 2 Ways to provide the id to the List
        /// 1. Pass explicitly the List what is id with Keypath, way to refer to a property of a type
        /// ie. `List(movies, id: \Movie.id)`, in the type Movie the id is the id property
        /// 2. Conform the type to `Identifieable`, procotol that have a requirement that whoever conforms it need to have id property
        /// ie.  `struct Movie : Identifiable`by conform to protocol, we does need to explicit tell SwiftUI bcs it know what the id is
        List(viewModel.movies) { movie in /// In the closure, it will give each element of the list that allow us to built in the row
            /// HStack : view that allow to arrange the view horizontally
            HStack {
                /// Load an image from movie poster url in movie data model
                /// AsyncImage(url: ) : SwiftUI built in type that allow to load image from URL asyncrhonously which mean the image not available immediately
                AsyncImage(url: movie.posterURL) { image  in
                    /// In closure : it allow to style the image after its available
                    image
                        .resizable() /// resizable() : allow the image to resize itself based on size that been set on  AsyncImage
                        .aspectRatio(contentMode: .fit) /// .aspectRatio(contentMode) : allow to tell the image to resize itself based on specify contentMode
                } placeholder: {  /// placeholder: closure that allow display while image is loading
                    
                    ProgressView() /// ProgressView() : SwiftUI built in type that allow to display loading spinner view when the view is loading
                }
                .frame(width: 80) /// .frame(width) : modifier that allow to specify the image size to display (width), this modifier propose size to  AsyncImage to use 80 points size but the image still allow to take as many size it wants
                
                
                /// VStack : view that allow to arrange the view vertically
                /// alignment: .leading : modifier in VStack that allow to arrage the view inside it to the left
                VStack(alignment: .leading) {
                    /// Text : built in view that allow to display text
                    Text(movie.title)
                        .font(.headline) /// .font : modifier that allow to modify the text font
                    
                    Text(movie.overview)
                        .lineLimit(4) /// .lineLimit  : modifier that allow to set maximum line of text in view, if more text will be truncated
                }
            }
            /// modifier : method that allow to be call in the UI to style the view
            .padding()  /// .padding : modifer that allow to add margin around the HStack
        }
        .task { /// .task : modifier similar like onAppear, allow to call async method
            await viewModel.loadMovies()
        }
    }
}

/// style configuration in view initialization vs view modifier
/// modifier : config that is optional, view still can be function if it not being provided
/// initialization : config that is important, view need to have some view to function, it by default had being added

/// generate preview on the canvas
struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        /// initialise mock movie data in the preview
        MovieView()
    }
}
