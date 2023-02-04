//
//  Prospect.swift
//  HotProspects
//
//  Created by Daniel Konnek on 4.02.2023.
//

import SwiftUI

@MainActor class Prospects: ObservableObject {
    @Published var people: [Prospect]

    init() {
        self.people = []
    }
}

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    var isContacted = false
}
