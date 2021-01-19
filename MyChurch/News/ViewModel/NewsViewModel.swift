// Sasha Loghozinsky -- alogozinsky@gmail.com \ lohozinsky.o@d2.digital -- 2020

import Foundation

protocol NewsDelegate: class {
    func didFinishFetchingData()
}

class NewsViewModel: ViewModel {
    
    init(delegate: NewsDelegate) {
        self.delegate  = delegate
    }
    
    weak var delegate: NewsDelegate?
    
    static var news: [Article]?
    
    func startFetchingData() {
        DispatchQueue.global(qos: .background).async {
            Repository.shared.getNews() { (response) in
                if let response = response {
                    NewsViewModel.news = response.data.list
                }
                DispatchQueue.main.async {
                    self.delegate?.didFinishFetchingData()
                }
            }
        }
    }
    
}
