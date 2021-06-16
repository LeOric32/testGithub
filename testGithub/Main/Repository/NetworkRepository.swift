import Foundation
import RxSwift

protocol NetworkRepositoryProtocol {
    func fetchCoins(queryString: String) -> Observable<[Item]>
}

class NetworkRepository {
    private let networkDataStore = NetworkDataStore() as NetworkDataStoreProtocol
    private let mapper = DataToItemModelMapper() as DataToItemModelMapperProtocol
}

extension NetworkRepository: NetworkRepositoryProtocol {
    func fetchCoins(queryString: String) -> Observable<[Item]> {
        return self.networkDataStore.fetchRepos(queryString: queryString).map { data in
            self.mapper.execute(from: data)
        }
    }
}
