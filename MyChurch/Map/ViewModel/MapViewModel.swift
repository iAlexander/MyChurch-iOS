// Sasha Loghozinsky -- alogozinsky@gmail.com \ lohozinsky.o@d2.digital -- 2020

import Foundation

protocol MapDelegate: class {
    func didFinishFetchingData(_ data: [Temple]?)
}

class MapViewModel: ViewModel {
    
    init(delegate: MapDelegate) {
        self.delegate = delegate
    }
    
    weak var delegate: MapDelegate?
    
    static var temples: [Temple]? {
        willSet {
            print("")
        }
    }
    
    func startFetchingData(lt: String, lg: String) {
        DispatchQueue.global(qos: .background).async {
            Repository.shared.getTemples(lt: lt, lg: lg) { (response) in
                MapViewModel.temples = response.data
                
                DispatchQueue.main.async {
                    self.delegate?.didFinishFetchingData(response.data)
                }
            }
        }
    }
    
}
