//
//  Prospect.swift
//  HotProspects
//
//  Created by Daniel Konnek on 4.02.2023.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    var dateAdded = Date()
    fileprivate(set) var isContacted = false
}

@MainActor class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedProspects")

    init() {
        do {
            let data = try Data(contentsOf: savePath)
             people = try JSONDecoder().decode([Prospect].self, from: data)
        } catch {
            people = []
        }
    }
    
    private func save() {
        do {
            let data = try JSONEncoder().encode(people)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
    
    func sortAlphabetically() {
        objectWillChange.send()
        people = people.sorted {
            $0.name < $1.name
        }
        save()
    }
    
    func sortByDateAdded() {
        objectWillChange.send()
        people = people.sorted {
            $0.dateAdded > $1.dateAdded
        }
        save()
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
}

