import UIKit

class UserDetailViewController: UITableViewController {
    @IBOutlet var postsTableView: UITableView!
    @IBOutlet weak var iconPhone: UIImageView!
    @IBOutlet weak var iconEmail: UIImageView!
        
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelPhone: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    
    var user: User?
    var posts: [Post?] = []

    func configure(with user: User) {
        self.user = user
    }
    
    override func viewDidLoad() {
        self.postsTableView.dataSource = self
        iconPhone?.image = UIImage(systemName: "phone")
        iconEmail?.image = UIImage(systemName: "mail")
        
        labelName.text = user?.name
        labelPhone.text = user?.phone
        labelEmail.text = user?.email
       
        if let userId = user?.id {
            Api().loadPostsData(userId: userId) { (posts) in
                self.posts = posts
                self.postsTableView.reloadData()
            }
        }
    }
}

extension UserDetailViewController {
    static let userDetailCellIdentifier = "UserDetailCell"
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Self.userDetailCellIdentifier, for: indexPath) as? PostListCell else {
            fatalError("Unable to dequeue")
        }
        let post = posts[indexPath.row]
        cell.labelTitle?.text = post?.title
        cell.labelBody?.text = post?.body
        return cell
    }
}
