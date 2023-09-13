//
//  Menu.swift
//  LittleLemon
//
//  Created by Jash Dhinoja on 13/09/2023.
//

import SwiftUI

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var searchText = ""
    
    func getMenuData (){
        PersistenceController.shared.clear()
        let urlString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request){ (data,_,_) in
            if let data = data{
                let decoder = JSONDecoder()
                let result = try? decoder.decode(MenuList.self, from: data)
            
                for menuItem in result!.menu {
                    let dish = Dish(context: viewContext)
                    dish.title = menuItem.title
                    dish.price = menuItem.price
                    dish.image = menuItem.image
                }
                try? viewContext.save()
            }
        }.resume()
    }
    
    func buildSortDescriptors() -> [NSSortDescriptor]{
        return [NSSortDescriptor(key: "title",
                                 ascending: true,
                                 selector: #selector(NSString.localizedStandardCompare)
                                )]
    }
    
    func buildPredicate() -> NSPredicate{
        return searchText.isEmpty ? NSPredicate(value: true) : NSPredicate(format: "title CONTAINS [cd] %@", searchText)

    }
    
    var body: some View {
        VStack(spacing: 10){
            Text("Little Lemon")
            Text("Chicago")
            Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
            TextField("Search Text", text: $searchText)
            FetchedObjects(
                sortDescriptors: buildSortDescriptors()
            ) { (dishes: [Dish]) in
                List{
                    ForEach(dishes){ dish in
                        HStack{
                            Text("Name: \(dish.title ?? "") Price: $\(dish.price ?? "")")
                            AsyncImage(url: URL(string: dish.image ?? "")){ image in
                                image.resizable()
                            } placeholder:{
                                ProgressView()
                            }
                            .frame(width: 50,height: 50)
                            
                        }
                        
                    }
                }
            }
        }
        .padding()
        .onAppear{
            getMenuData()
        }
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
