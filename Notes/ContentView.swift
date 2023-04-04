//
//  ContentView.swift
//  Notes
//
//  Created by user236826 on 4/2/23.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    
    @StateObject var noteApp = NoteViewModel()
    @State var note = NoteModel(title: "", notesdata: "")
    
    @State var outsuccess:Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach($noteApp.notes) { $note in NavigationLink {
                    NoteDetail(note: $note)
                    } label: {
                        Text(note.title)
                    }
                }
                Section {
                    NavigationLink {
                        NoteDetail(note: $note)
                        } label: {
                            Text("New note")
                                .foregroundColor(Color.gray)
                                .font(.system(size: 15))
                        }
                }
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Sign out") {
                        logout()
                    }.navigationDestination(isPresented: $outsuccess, destination: { AuthView() })
                }
            }
            .onAppear {
                noteApp.fetchData()
            }
            .refreshable {
                noteApp.fetchData()
            }
        }
    }
    
    func logout() {
        do {
            try
                Auth.auth().signOut()
                outsuccess = true
            } catch let signOutError as NSError {
                print("Error signing out: %@", signOutError)
                outsuccess = false
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
