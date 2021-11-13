import UIKit

class UserListViewController: UITableViewController {
    @IBOutlet var usersTableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    static let showDetailSegueIdentifier = "ShowUserDetailSegue"
    
    var users: [User?] = []
    var searchedUsers: [User?] = []
    var searching = false
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Self.showDetailSegueIdentifier,
           let destination = segue.destination as? UserDetailViewController,
           let cell = sender as? UITableViewCell,
           let indexPath = tableView.indexPath(for: cell) {
            let user = users[indexPath.row]
            if let user = user {
                destination.configure(with: user)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
        self.usersTableView.dataSource = self
        Api().loadUsersData { (users) in
            self.users = users
            self.usersTableView.reloadData()
        }
    }
}

extension UserListViewController {
    static let userListCellIdentifier = "UserListCell"
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (searching) {
            return searchedUsers.count
        } else {
            return users.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Self.userListCellIdentifier, for: indexPath) as? UserListCell else {
            fatalError("Unable to dequeue")
        }
        let user = (searching ? searchedUsers[indexPath.row] : users[indexPath.row])
        cell.imagePhone?.image = UIImage(systemName: "phone")
        cell.imageMail?.image = UIImage(systemName: "mail")
        cell.labelUserName.text = user?.name
        cell.labelPhone.text = user?.phone
        cell.labelEmail.text = user?.email
        return cell
    }
}

extension UserListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedUsers = users.filter { $0?.name?.lowercased().prefix(searchText.count) ?? "" == searchText.lowercased() }
        searching = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.reloadData()
    }
}
