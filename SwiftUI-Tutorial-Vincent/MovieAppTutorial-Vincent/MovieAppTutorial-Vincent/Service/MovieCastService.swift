//
//  MovieCastService.swift
//  MovieAppTutorial-Vincent
//
//  Created by Ikmal Azman on 31/01/2023.
//

import Foundation

final class MovieCastService {
    
    private let decoder : JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    
    /// method to make API call to get cast of the movie
    /// - Parameter movie: require Movie object as an input and use its id to to builf URL of the API endpoint
    /// - Returns: collection of MovieCastMember
    func getCast(of movie : Movie) async throws -> [MovieCastMember] {
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movie.id)/credits?api_key=\(apiKey)&language=en-US")!
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        let decodedData = try decoder.decode(MovieCastResponse.self, from: data)
        
        return decodedData.cast
    }
}
