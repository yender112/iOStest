//
//  Api.swift
//  apptest
//
//  Created by Yenderson Sanchez Galindo on 12/11/21.
//

import Foundation

class Api : ObservableObject{
    @Published var books = [User]()
    
    func loadUsersData(completion:@escaping ([User]) -> ()) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            let users = try! JSONDecoder().decode([User].self, from: data!)
            print(users)
            DispatchQueue.main.async {
                completion(users)
            }
        }.resume()
    }
    
    func loadPostsData(userId: Int, completion:@escaping ([Post]) -> ()) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts?userId=\(userId)") else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            let posts = try! JSONDecoder().decode([Post].self, from: data!)
            print(posts)
            DispatchQueue.main.async {
                completion(posts)
            }
        }.resume()
    }
}
