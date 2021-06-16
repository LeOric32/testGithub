import Foundation

protocol DataToItemModelMapperProtocol {
    func execute(from data: Data) -> [Item]
}

class DataToItemModelMapper: DataToItemModelMapperProtocol {
    func execute(from data: Data) -> [Item] {
        
        let responseModel = try? JSONDecoder().decode(ResponseModel.self, from: data)
        guard let items = responseModel?.items else { return [] }
        return items
    }
}
