//
//  ImageViewModel.swift
//  MeteoMVVMCombine
//
//  Created by David Grammatico on 08/06/2021.
//

import UIKit
import Combine

class ImageViewModel: ObservableObject {
    
    
    @Published var uiImage: UIImage?
    var iconUrl: String
    var cancellable: AnyCancellable?
    var session = URLSession.shared
    
    init(_ string: String) {
        self.iconUrl = string
        load()
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    func load() {
        let urlString = "http://openweathermap.org/img/wn/\(iconUrl).png"
        guard let url = URL(string: urlString) else {return}
        cancellable = session.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data)}
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] in
                self?.uiImage = $0
            })
    }
}
