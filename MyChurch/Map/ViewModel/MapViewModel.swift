// Sasha Loghozinsky -- alogozinsky@gmail.com \ lohozinsky.o@d2.digital -- 2020

import Foundation
import ANLoader
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
        ANLoader.activityBackgroundColor = UIColor(red: 0.004, green: 0.475, blue: 0.898, alpha: 1)
        if Reachability.isConnectedToNetwork() {
            ANLoader.showLoading("Завантаження...", disableUI: true)
        }
        DispatchQueue.global(qos: .background).async {
            Repository.shared.getTemples(lt: lt, lg: lg) { (response) in
                MapViewModel.temples = response?.list
                DispatchQueue.main.async {
                    self.delegate?.didFinishFetchingData(response?.list)
                }
            }
        }
    }
    
}
