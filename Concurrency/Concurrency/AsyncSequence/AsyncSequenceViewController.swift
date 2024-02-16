//
//  AsynchronousSequencesViewController.swift
//  Concurrency
//
//  Created by 김건우 on 2/5/24.
//

import UIKit

struct ImageIterator: AsyncIteratorProtocol {
    let imageList: [String]
    var current = 0
    
    mutating func next() async throws -> String? {
        guard current < imageList.count else {
            return nil
        }
        try await Task.sleep(nanoseconds: 3 * 1_000_000_000)
        
        let image = imageList[current]
        current += 1
        return image
    }
}

struct ImageLoader: AsyncSequence {
    typealias Element = String // 시퀀스가 반환하는 데이터 타입
    let imageList: [String]
    
    func makeAsyncIterator() -> ImageIterator {
        return ImageIterator(imageList: imageList)
    }
}

class AsyncSequenceViewController: UIViewController {

    var imageList = ["image1", "image2", "image3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Task(priority: .background) {
            let loader = ImageLoader(imageList: imageList)
            for try await image in loader {
                print(image)
            }
        }
    }
    
}
