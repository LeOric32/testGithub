import UIKit
import RxSwift

@objc protocol BasePresenterProtocol {
    func viewDidLoad()
    func viewWillAppear(_ animated : Bool)
    func viewDidAppear(_ animated : Bool)
    func viewWillDisappear(_ animated : Bool)
    func viewDidDisappear(_ animated : Bool)
    func viewDidLayoutSubviews()
    func setBaseController(controller : BaseViewControllerProtocol?)
}

class BasePresenter: NSObject, BasePresenterProtocol {
  
    
    var baseView: BaseView?
    var baseController: BaseViewControllerProtocol?
    var disposeBag = DisposeBag()

    func viewDidLoad() {

    }
    
    func viewWillAppear(_ animated: Bool) {
        
    }
    
    func viewDidAppear(_ animated: Bool) {
        
    }
    
    func viewWillDisappear(_ animated: Bool) {
        
    }
    
    func viewDidDisappear(_ animated: Bool) {
    
    }
    
    func viewDidLayoutSubviews() {
        
    }
    
    func setBaseController(controller: BaseViewControllerProtocol?) {
        self.baseController = controller
    }
}
