import UIKit
import RxSwift

enum RequestMethod : String {
    case GET = "GET"
    case PUT = "PUT"
    case POST = "POST"
    case DELETE = "DELETE"
}


class BaseDataStore {
    
    private func requestWithMethod(httpMethod : String ,url : URL) -> URLRequest {
        var request = URLRequest(url : url)
        request.httpMethod = httpMethod
        return request
    }
    
    private func requestWithMethodAndQuery(httpMethod : String ,url : String, queryString: String) -> URLRequest? {
        guard var components = URLComponents(string: url) else {
            return nil
        }
            components.queryItems = [URLQueryItem(name: "q", value: queryString)]
        
            components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
            var request = URLRequest(url: components.url!)
        request.httpMethod = httpMethod
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    
    func requestDataWith(url : String, httpMethod: RequestMethod, queryString: String?) -> Observable<Data> {
        return Observable.create {observer in
            guard let request = self.requestWithMethodAndQuery(httpMethod: httpMethod.rawValue, url: url, queryString: queryString ?? "") else {
                return Disposables.create()
            }
            
            
            
            let session = URLSession.shared.dataTask(with: request) {
                data, response, error in
                self.processResponse(observer: observer, data: data, response: response, error: error)
            }
            
            session.resume()
            return Disposables.create() {
                session.cancel()
            }
        }
    }
    
    func processResponse(observer: AnyObserver<Data>, data: Data?, response: URLResponse?, error: Error?) {
        let httpResp = response as? HTTPURLResponse
        if (httpResp?.statusCode != 200 && httpResp?.statusCode != 201) {
            if (error != nil) {
                observer.onError(error!)
                observer.onCompleted()
            }
            guard let _ = data else {
                observer.onError(self.unknownError())
                return
            }
        } else {
            if error == nil && data != nil {
                observer.onNext(data!)
            } else {
                observer.onError(error!)
            }
        }
        observer.onCompleted()
    }
    
    private func unknownError () -> Error {
        let error = NSError.init(domain: "Hashtag Guru", code: 0, userInfo: [NSLocalizedDescriptionKey : "Unkown error"])
        return error as Error
    }
}
