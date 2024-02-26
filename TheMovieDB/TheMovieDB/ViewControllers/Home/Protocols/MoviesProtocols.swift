//
//  MoviesProtocols.swift
//  TheMovieDB
//
//  Created by Geovanni Josue Chavez on 24/2/24.
//

import Foundation

protocol MoviesView {
    func renderUI(filters: [String])
    func renderTVShows()
    func showGenericDialog(content: String, completion: (() -> Void)?)
}
