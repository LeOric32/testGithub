import UIKit

@objc protocol BaseViewControllerProtocol {
    func pushViewController(viewController : UIViewController, animated : Bool)
    func popViewController(toRoot : Bool, animated : Bool)
    func presentViewController(viewController : UIViewController, animated : Bool, completion : (()->Void)?)
    func dismissViewController(animated : Bool, completion : (()->Void)?)
    
}


class BaseViewController: UIViewController {
    
    var basePresenters : [BasePresenterProtocol?]?
    
    override func viewDidLoad() {
        guard let presenters = self.basePresenters else {return}
        for presenter in presenters {
            presenter?.viewDidLoad()
        }
    }
    
    override func viewWillAppear(_ animated :Bool) {
        guard let presenters = self.basePresenters else {return}
        for presenter in presenters {
            presenter?.viewWillAppear(animated)
        }
    }
    
    override func viewDidAppear(_ animated : Bool) {
        guard let presenters = self.basePresenters else {return}
        for presenter in presenters {
            presenter?.viewDidAppear(animated)
        }
    }
    
    override func viewWillDisappear(_ animated : Bool) {
        guard let presenters = self.basePresenters else {return}
        for presenter in presenters {
            presenter?.viewWillDisappear(animated)
        }
    }
    
    override func viewDidLayoutSubviews() {
        guard let presenters = self.basePresenters else {return}
        for presenter in presenters {
            presenter?.viewDidLayoutSubviews()
        }
    }
    
}

extension BaseViewController : BaseViewControllerProtocol {
    func pushViewController(viewController: UIViewController, animated: Bool) {
        self.navigationController?.pushViewController(viewController, animated: animated)
    }
    func popViewController(toRoot: Bool, animated: Bool) {
        if (toRoot) {
            self.popToRootViewController(animated: animated)
        } else {
            self.navigationController?.popViewController(animated: animated)
        }
    }
    
    func presentViewController(viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        self.present(viewController, animated: animated, completion: completion)
    }
    
    func dismissViewController( animated: Bool, completion: (() -> Void)?) {
        self.dismiss(animated: animated, completion: completion)
    }
    
    private func popToRootViewController(animated : Bool) {
        self.navigationController?.popToRootViewController(animated: animated)
    }
}
