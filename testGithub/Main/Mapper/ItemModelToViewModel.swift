import Foundation

protocol ItemModelToViewModelProtocol {
    func execute(from itemModel: Item) -> ItemViewModel
}

class ItemModelToViewModel: ItemModelToViewModelProtocol {
    func execute(from itemModel: Item) -> ItemViewModel {
        let url = itemModel.url ?? ""
        let name = itemModel.fullName ?? ""
        let viewModel = ItemViewModel(url: url, name: name)
        return viewModel
    }
}
