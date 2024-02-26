//
//  DialogModel.swift
//  TheMovieDB
//
//  Created by Geovanni Josue Chavez on 24/2/24.
//

import Foundation

struct DialogModel {
    var title: String?
    var content: String?
    var buttonAccept: String?
    var buttonCancel: String?
    
    init(title: String? = nil, content: String? = nil, buttonAccept: String? = nil, buttonCancel: String? = nil) {
        self.title = title
        self.content = content
        self.buttonAccept = buttonAccept
        self.buttonCancel = buttonCancel
    }
}

class DialogModelBuilder {
    
    private var dialogContent = DialogModel()
    
    @discardableResult
    func addTitle(_ title: String) -> DialogModelBuilder {
        self.dialogContent.title = title
        return self
    }
    
    @discardableResult
    func addContent(_ content: String) -> DialogModelBuilder {
        self.dialogContent.content = content
        return self
    }
    
    @discardableResult
    func addAcceptButton(_ content: String) -> DialogModelBuilder {
        self.dialogContent.buttonAccept = content
        return self
    }
    
    @discardableResult
    func addCancelButton(_ content: String) -> DialogModelBuilder {
        self.dialogContent.buttonCancel = content
        return self
    }
    
    func build() -> DialogModel {
        return self.dialogContent
    }
    
}
