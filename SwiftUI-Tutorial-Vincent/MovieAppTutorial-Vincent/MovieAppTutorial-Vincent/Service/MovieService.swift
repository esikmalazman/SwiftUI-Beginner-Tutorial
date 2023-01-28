//
//  MovieService.swift
//  MovieAppTutorial-Vincent
//
//  Created by Ikmal Azman on 24/01/2023.
//

import Foundation

final class MovieService {
    
    /// method to make API call to get movies data
    /// - Returns: collection of Movie object
    
    func getMoviesFromAPI() async throws -> [Movie] {
        /// URL of the API endpoint to query to the upcoming movie
        let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=\(apiKey)")!
        
        ///  built in `async` in Swift to make API `GET` request  operation that accept URL as input that
        /// `async method`, allow to pause during it execution, ie to wait for data to revice from server. When the method pause, it can't be call from anywhere, so by mark `Async` it let compiler know the method can be pause
        /// `await` : keyword to mark the method can pause during its execution
        /// `try` : keyword to mark that the method can generate to potential error
        /// `throws` : keyword to mark that the method can throw error if it occurs
        
        /// The method return 2 type of data
        /// 1. data : binary data returns from network call
        /// 2. response : metadata from Http response
        let (data, response) = try await URLSession.shared.data(from: url)
        
        /// JSONDecoder, object to decode binary data
        let decoder = JSONDecoder()
        /// tell decoder to convert from snakeCase from API to camelCase
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        /// method from decoder to decode the data, it accept type that has `decodable` type and a binary data that recevie from API call
        let decodedData = try decoder.decode(MovieResponse.self, from: data)
        
        /// return collection of movie from decoded data
        return decodedData.results
    }
}
