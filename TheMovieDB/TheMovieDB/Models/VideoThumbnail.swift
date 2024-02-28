//
//  VideoThumbnail.swift
//  TheMovieDB
//
//  Created by Geovanni Josue Chavez on 27/2/24.
//

import Foundation

struct VideoThumbnail {
    var title: String?
    var thumbnailUrl: String?
    var channelIconUrl: String?
    
    init(title: String? = nil, thumbnailUrl: String? = nil, channelIconUrl: String? = nil) {
        self.title = title
        self.thumbnailUrl = thumbnailUrl
        self.channelIconUrl = channelIconUrl
    }
}
