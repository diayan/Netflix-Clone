//
//  NFError.swift
//  Netflix Clone
//
//  Created by diayan siat on 26/02/2022.
//

import Foundation

enum NFError: String, Error{
    case unableToComplete = "Unable to complete your request. Please check your internet connection"
    case invalidResponse  = "Invalid response from the server. Please try again!"
    case invalidData      = "The data received from the server was invalid. Please try again"
    case failedToSaveData = "Failed to save data"
    case failedToFetchData = "Failed to fetch data at this moment"
}

