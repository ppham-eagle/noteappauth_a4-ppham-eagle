//
//  NoteModel.swift
//  Notes
//
//  Created by user236826 on 4/2/23.
//

import Foundation
import FirebaseFirestoreSwift

struct NoteModel: Codable, Identifiable {
    @DocumentID var id: String?
    var title: String
    var notesdata: String
}
