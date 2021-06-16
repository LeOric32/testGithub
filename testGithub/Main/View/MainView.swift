import UIKit

@objc protocol MainViewProtocol {
    func register(nib : UINib?, forCellReuseIdentifier : String)
    func setTableViewDelegate(delegate : UITableViewDelegate & UITableViewDataSource)
    func reloadTableView()
    func showTableView()
    func hideTableView()
    func setSearchBarDelegate(delegate: UISearchBarDelegate)
    func hideKeyboard()
    func activityIsHidden(isHidden: Bool)
}

class MainView: BaseView {
    
    @IBOutlet weak var reposTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}

extension MainView: MainViewProtocol {
    
    func register(nib: UINib?, forCellReuseIdentifier: String) {
        self.reposTableView?.register(nib, forCellReuseIdentifier: forCellReuseIdentifier)
    }
    
    func setTableViewDelegate(delegate: UITableViewDataSource & UITableViewDelegate) {
        self.reposTableView.delegate = delegate
        self.reposTableView.dataSource = delegate
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.reposTableView.reloadData()
        }
    }
    
    func showTableView() {
        DispatchQueue.main.async {
            self.reposTableView.isHidden = false
        }
        
    }
    
    func hideTableView() {
        DispatchQueue.main.async {
            self.reposTableView.isHidden = true
        }
    }
    
    
    func setSearchBarDelegate(delegate: UISearchBarDelegate) {
        self.searchBar.delegate = delegate
    }
    
    func hideKeyboard() {
        self.endEditing(true)
    }
    
    func activityIsHidden(isHidden: Bool) {
        DispatchQueue.main.async {
            self.activityIndicator.isHidden = isHidden
        }
    }
}
