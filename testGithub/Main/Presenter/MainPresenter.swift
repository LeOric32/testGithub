import UIKit
import RxSwift

@objc protocol MainPresenterProtocol: BasePresenterProtocol {
    func fetchCoins(queryString: String)
}

class MainPresenter: BasePresenter {
    //интеракторы, вью и вьюмодель
    @IBOutlet weak var mainView : MainViewProtocol?
    private let mainInteractor = MainInteractor() as MainInteractorProtocol
    private var repos: [ItemViewModel]? {
        didSet {
            self.mainView?.reloadTableView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainView?.setTableViewDelegate(delegate: self)
        self.mainView?.setSearchBarDelegate(delegate: self)
        self.mainView?.register(nib: UINib(nibName: "RepoCellTableViewCell", bundle: nil), forCellReuseIdentifier: "RepoCellTableViewCell")
        
    }
}

extension MainPresenter: MainPresenterProtocol {
    func fetchCoins(queryString: String) {
        let _ = mainInteractor.fetchCoinsData(queryString: queryString).subscribe { models in
            self.mainView?.activityIsHidden(isHidden: true)
            self.mainView?.showTableView()
            self.repos = models
        } onError: { e in
            print(e)
        } onCompleted: {} onDisposed: {}

    }
}

extension MainPresenter: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepoCellTableViewCell") as? RepoCellTableViewCell ?? RepoCellTableViewCell()
        cell.itemViewModel = repos?[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? RepoCellTableViewCell ?? RepoCellTableViewCell()
        if let url = URL(string: "https://github.com/\(cell.nameLabel.text!)") {
            UIApplication.shared.open(url)
        }
    }
}

extension MainPresenter: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        mainView?.hideKeyboard()
        mainView?.hideTableView()
        mainView?.activityIsHidden(isHidden: false)
        guard let text = searchBar.text else { return }
        
        fetchCoins(queryString: text)
    }
    
}


