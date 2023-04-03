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
    @State var success: Bool = false
    
    var body: some View {
        VStack {
            TextField("Email (must be valid)", text: $email)
                .textContentType(.emailAddress)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .keyboardType(.emailAddress)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 40).stroke(Color.black))
                .padding()
                .focused($focused)
            SecureField("Password (8 characters minimum)", text: $password)
                .textContentType(.password)
                .keyboardType(.default)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 40).stroke(Color.black))
                .padding()
                .focused($focused)
            Button {
                login()
                focused = false
            } label: {
                Text("Sign In").frame(alignment: .center)
            }
            .alert("Log in successful!", isPresented: $success) {
                Button("OK", role: .cancel) { }
            }
            .padding()
            .buttonStyle(.bordered)
            Button {
                register()
                focused = false
            } label: {
                Text("Sign Up").frame(alignment: .center)
                    .foregroundColor(Color.red)
            }
            .padding()
            .buttonStyle(.bordered)
            Text("Please sign up, then sign in if you don't have an account.")
                .frame(alignment: .center)
                .padding()
            Text("If you have signed up for a valid account, you will get an alert box pop up when you enter your valid email and password and press the sign in button.")
                .padding()
            Text("The accounts are stored on my Firebase's Firestore.")
            Spacer()
        }
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                success = true
            }
        }
        email = ""
        password = ""
    }
    
    func register() {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if error != nil {
                print(error!.localizedDescription)
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
