
import UIKit

class StoreItemListTableViewController: UITableViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var filterSegmentedControl: UISegmentedControl!
    
    // add item controller property
    var storeItemController = StoreItemController()
    
    // update the items array to [StoreItem] type
    var items = [StoreItem]()
    
    let queryOptions = ["movie", "music", "software", "ebook"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func fetchMatchingItems() {
        
        self.items = []
        self.tableView.reloadData()
        
        let searchTerm = searchBar.text ?? ""
        let mediaType = queryOptions[filterSegmentedControl.selectedSegmentIndex]
        
        if !searchTerm.isEmpty {
            
            // set up query dictionary
            let query = ["term": "\(searchTerm.lowercased())", "media": "\(mediaType)", "lang": "en_us"]
            
            // use the item controller to fetch items
            storeItemController.fetchItems(matching: query, completion: {(storeItem) in
                if let storeItem = storeItem {
                    // if successful, use the main queue to set self.items and reload the table view
                    // update for function to be executed on the main queue
                    self.items = storeItem
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            })
            // otherwise, print an error to the console
        }
    }
    
    func configure(cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        
        let item = items[indexPath.row]
        
        // set label to the item's name
        cell.textLabel?.text = item.trackName
        // set detail label to the item's subtitle
        cell.detailTextLabel?.text = item.artistName
        // reset the image view to the gray image
        cell.imageView?.image = UIImage(named: "gray")
        
        // initialize a network task to fetch the item's artwork
        let task = URLSession.shared.dataTask(with: item.artworkUrl, completionHandler: {(data, response, error) in
            guard let data = data,
                let image = UIImage(data: data) else { return }
            // if successful, use the main queue capture the cell, to initialize a UIImage, and set the cell's image view's image to the image view
            DispatchQueue.main.async {
                cell.imageView?.image = image
            }
        })
        // resume the task
        task.resume()
        
    }
    
    @IBAction func filterOptionUpdated(_ sender: UISegmentedControl) {
        
        fetchMatchingItems()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
        configure(cell: cell, forItemAt: indexPath)

        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension StoreItemListTableViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        fetchMatchingItems()
        searchBar.resignFirstResponder()
    }
}
