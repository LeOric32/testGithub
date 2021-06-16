import Foundation
import RxSwift

protocol MainInteractorProtocol {
    func fetchCoinsData(queryString: String) -> Observable<[ItemViewModel]>
}

class MainInteractor {
    private let networkRepository = NetworkRepository() as NetworkRepositoryProtocol
    private let toViewModelMapper = ItemModelToViewModel() as ItemModelToViewModelProtocol
    private let fromDatatoCoinModelMapper = DataToItemModelMapper() as DataToItemModelMapperProtocol
}

extension MainInteractor: MainInteractorProtocol {
    
    func fetchCoinsData(queryString: String) -> Observable<[ItemViewModel]> {
        return self.networkRepository.fetchCoins(queryString: queryString).flatMap { models -> Observable<[ItemViewModel]> in
            
            var viewModels = [ItemViewModel]()
            models.forEach {model in
                let viewModel = self.toViewModelMapper.execute(from: model)
                viewModels.append(viewModel)
            }
            return Observable.just(viewModels)
        }
    }
}


