// Sasha Loghozinsky -- alogozinsky@gmail.com \ lohozinsky.o@d2.digital -- 2020

import Foundation
import AVFoundation

protocol PrayerDelegate: class {
    func didFinishFetchingData()
    func didFinishFetchingAudio()
}

class PrayerViewModel: ViewModel {
    
    init(delegate: PrayerDelegate) {
        self.delegate  = delegate
    }
    
    weak var delegate: PrayerDelegate?
    
    static var prayers: [String : [Prayer]]?
    static var currentAudioData: Data?
    
    func startFetchingData() {
        DispatchQueue.global(qos: .background).async {
            Repository.shared.getPrayer() { (response) in
                if let data = response.data?.list {
                    PrayerViewModel.prayers = Dictionary(grouping: data, by: { ($0.type ?? "") })
                }
                
                DispatchQueue.main.async {
                    self.delegate?.didFinishFetchingData()
                }
            }
        }
    }
    
    func startFetchingAudio(url: URL) {
        DispatchQueue.global(qos: .background).async {
            Repository.shared.getAudioData(url: url) { (response) in
                let audio = try! Data(contentsOf: url)
                PrayerViewModel.currentAudioData = audio
                
                DispatchQueue.main.async {
                    self.delegate?.didFinishFetchingAudio()
                }
            }
            
        }
    }
    
    func makePath(data: FileData?) -> String? {
        guard let fileData = data else { return nil }
        
        let apiPath: String = {
            var result = API.stage.rawValue
            result.removeLast()
            
            return result
        }()
        let path = fileData.path + "/"
        let name = fileData.name
        let result = apiPath + path + name
        print(result)
        
        return result
    }
    
}
