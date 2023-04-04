//
//  AuthView.swift
//  Notes
//
//  Created by user236826 on 4/2/23.
//

import SwiftUI
import FirebaseAuth

struct AuthView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    @FocusState private var focused: Bool
    @State var insuccess: Bool = false
    @State var upsuccess: Bool = false
    
    var body: some View {
        NavigationStack {
            Text("Note Board App Login")
                .font(.title)
            TextField("Email (must be valid)", text: $email)
                .textContentType(.emailAddress)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .keyboardType(.emailAddress)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black))
                .frame(width: 350)
                .padding(.bottom)
                .focused($focused)
            SecureField("Password (8 characters minimum)", text: $password)
                .textContentType(.password)
                .keyboardType(.default)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black))
                .frame(width: 350)
                .focused($focused)
            Button {
                login()
                focused = false
            } label: {
                Text("Sign In").frame(alignment: .center)
                    .foregroundColor(Color.blue)
            }
            .navigationDestination(isPresented: $insuccess, destination: { ContentView() })
            .padding(.top)
            .buttonStyle(.bordered)
            Button {
                register()
                focused = false
            } label: {
                Text("Sign Up").frame(alignment: .center)
                    .foregroundColor(Color.red)
            }
            .alert("Account creation successful!", isPresented: $upsuccess) {
                Button("OK", role: .cancel) { }
            }
            .padding()
            .buttonStyle(.bordered)
            VStack (alignment: .leading) {
                Text("Note:")
                Text("- Please sign up, then sign in if you don't have an account")
                Text("- A successful sign up will pop up an alert")
                Text("- Accounts are stored on Firebase")
            }
            Spacer()
            /*
            .navigationTitle("Note Board App Login")
            .navigationBarTitleDisplayMode(.inline)
             */
            .navigationBarHidden(true)
        }
        /*
        .onTapGesture {
            focused = false
        }
        */
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if error != nil {
                print(error!.localizedDescription)
                insuccess = false
            } else {
                insuccess = true
            }
        }
        email = ""
        password = ""
    }
    
    func register() {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if error != nil {
                print(error!.localizedDescription)
                upsuccess = false
            } else {
                upsuccess = true
            }
        }
        email = ""
        password = ""
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
