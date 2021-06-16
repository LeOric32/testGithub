import Foundation
import RxSwift

protocol NetworkDataStoreProtocol {
    func fetchRepos(queryString: String) -> Observable<Data>
}

class NetworkDataStore: BaseDataStore {}

extension NetworkDataStore: NetworkDataStoreProtocol {
    func fetchRepos(queryString: String) -> Observable<Data> {
        
        return self.requestDataWith(url: "https://api.github.com/search/repositories",
                                    httpMethod: .GET, queryString: queryString)
    }
}
