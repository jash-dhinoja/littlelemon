//
//  UserProfile.swift
//  LittleLemon
//
//  Created by Jash Dhinoja on 13/09/2023.
//

import SwiftUI

struct UserProfile: View {
    
    let firstName = UserDefaults.standard.string(forKey: "firstNameKey")
    let lastName = UserDefaults.standard.string(forKey: "lastNameKey")
    let email = UserDefaults.standard.string(forKey: "emailKey")
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack{
            Text("Personal information")
            Image("profile-image-placeholder")
            Text(firstName ?? "")
            Text(lastName ?? "")
            Text(email ?? "")
            Button("Logout") {
                UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                self.presentation.wrappedValue.dismiss()
            }
            Spacer()
        }
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
