//
//  onboarding.swift
//  LittleLemon
//
//  Created by Jash Dhinoja on 13/09/2023.
//

import SwiftUI

let kFirstName = "firstNameKey"
let kLastName = "lastNameKey"
let kEmail = "emailKey"
let kIsLoggedIn = "kIsLoggedIn"

struct onboarding: View {
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    @State var isLoggedIn = false
    
    var body: some View {
        NavigationView{
            VStack{
                NavigationLink( destination: Home(),isActive: $isLoggedIn){
                    EmptyView()
                }
                TextField(text: $firstName){
                    Text("First Name")
                }
                TextField(text: $lastName){
                    Text("Last Name")
                }
                TextField(text: $email){
                    Text("Email")
                }
                Button("Register"){
                    if !firstName.isEmpty || !lastName.isEmpty || !email.isEmpty{
                        UserDefaults.standard.set(firstName, forKey: kFirstName)
                        UserDefaults.standard.set(lastName, forKey: kLastName)
                        UserDefaults.standard.set(email, forKey: kEmail)
                        UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                        isLoggedIn = true
                    }
                }
            }
            .padding()
            .onAppear{
                if UserDefaults.standard.bool(forKey: kIsLoggedIn){
                    isLoggedIn = true
                }
            }
        }
    }
}

struct onboarding_Previews: PreviewProvider {
    static var previews: some View {
        onboarding()
    }
}
