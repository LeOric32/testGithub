import UIKit

class MainViewController: BaseViewController {
    
    @IBOutlet var mainPresenter: MainPresenterProtocol!
    
    override func viewDidLoad() {
        self.basePresenters = [self.mainPresenter]
        self.basePresenters?.forEach( { presenter in
            presenter?.setBaseController(controller: self)
        })
        super.viewDidLoad()
    }
}

