//
//  BooksViewController.swift
//  StudySphere
//
//  Created by 靳肖阳 on 4/29/23.
//

import UIKit

class BooksViewController: UIViewController, UITableViewDataSource {
    
    var books: [Book] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! BookCell

        let book = books[indexPath.row]

        cell.configure(with: book)

        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=study+inauthor:keyes&key=AIzaSyDj939MrhvAFe47LlfWyzNJyPr-KTll7Ko")!
        // Use the URL to instantiate a request
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in

            // Handle any errors
            if let error = error {
                print("❌ Network error: \(error.localizedDescription)")
            }

            // Make sure we have data
            guard let data = data else {
                print("❌ Data is nil")
                return
            }

            // The `JSONSerialization.jsonObject(with: data)` method is a "throwing" function (meaning it can throw an error) so we wrap it in a `do` `catch`
            // We cast the resultant returned object to a dictionary with a `String` key, `Any` value pair.
            do {
                
                let jsonDictionary = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                print(jsonDictionary)
                
                // Create a JSON Decoder
                let decoder = JSONDecoder()

                let response = try decoder.decode(BookResponse.self, from: data)
                // Access the array of tracks from the `results` property
                let books = response.items

                // Execute UI updates on the main thread when calling from a background callback
                DispatchQueue.main.async {

                    // Set the view controller's books property as this is the one the table view references
                    self?.books = books

                    // Make the table view reload now that we have new data
                    self?.tableView.reloadData()
                }
                print("✅ \(self?.books)")
            } catch {
                print("❌ Error parsing JSON: \(error.localizedDescription)")
            }
        }
        // Initiate the network request
        task.resume()
        //print("👋 Below the closure")
        print(books)

        tableView.dataSource = self
    }

}
