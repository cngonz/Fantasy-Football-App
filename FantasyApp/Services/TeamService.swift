//
//  TeamService.swift
//  FantasyApp
//
//  Created by Cesar N. Gonzalez on 8/24/26.
//

import FirebaseFirestore
import FirebaseAuth

final class TeamService: ObservableObject {
    static let shared = TeamService()
    @Published var teams: [Team] = []
    @Published var errorMessage: String?

    private let db = Firestore.firestore()
    private var listener: ListenerRegistration?

    private init() {}

    func startListening() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        listener?.remove()
        listener = db.collection("users").document(uid).collection("teams")
            .addSnapshotListener { [weak self] snapshot, error in
                if let error = error {
                    self?.errorMessage = error.localizedDescription
                    return
                }
                self?.teams = snapshot?.documents.compactMap {
                    try? $0.data(as: Team.self)
                } ?? []
            }
    }

    func stopListening() {
        listener?.remove()
    }

    func saveTeam(_ team: Team, completion: @escaping (Bool, String?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion(false, "You must be signed in to save a team.")
            return
        }
        do {
            try db.collection("users").document(uid).collection("teams")
                .document(team.id).setData(from: team)
            completion(true, nil)
        } catch {
            completion(false, error.localizedDescription)
        }
    }

    func deleteTeam(_ team: Team) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        db.collection("users").document(uid).collection("teams").document(team.id).delete()
    }
}
