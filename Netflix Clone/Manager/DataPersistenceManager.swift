//
//  DataPersistenceManager.swift
//  Netflix Clone
//
//  Created by diayan siat on 01/03/2022.
//

import Foundation
import UIKit
import CoreData

class DataPersistenceManager {
    static let shared = DataPersistenceManager()
    
    func downloadMovie(movie: Movies, completion: @escaping (Result<Void, NFError>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        let item = MovieItem(context: context) //item we are storing
        item.id = Int64(movie.id ?? 0)
        item.originalTitle = movie.originalTitle
        item.originalName = movie.originalName
        item.name = movie.name
        item.backdropPath = movie.backdropPath
        item.firstAirDate = movie.firstAirDate
        item.originalLanguage = movie.originalLanguage
        item.posterPath = movie.posterPath
        item.voteAverage = movie.voteAverage ?? 0.0
        item.voteCount = Int64(movie.voteCount ?? 0)
        item.overview = movie.overview
        item.popularity = movie.popularity ?? 0.0
        item.mediaType = movie.mediaType
        item.releaseDate = movie.releaseDate
        item.video = movie.video ?? false
        item.title = movie.title
        item.adult = movie.adult ?? false
        
        do {
            try context.save()
            completion(.success(()))
        }catch {
            completion(.failure(.failedToSaveData))
            print(error.localizedDescription)
        }
    }
}
