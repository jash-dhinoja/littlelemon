//
//  Home.swift
//  LittleLemon
//
//  Created by Jash Dhinoja on 13/09/2023.
//

import SwiftUI

struct Home: View {
    
    let persistence = PersistenceController.shared
    
    var body: some View {
        TabView{
            Menu()
                .environment(\.managedObjectContext, persistence.container.viewContext)
                .tabItem{
                    Label("Menu", systemImage: "list.dash")
                }
            UserProfile()
                .tabItem{
                    Label("Profile", systemImage: "square.and.pencil")
                }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
