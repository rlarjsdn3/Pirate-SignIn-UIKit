//
//  ConcurrencyViewController.swift
//  Concurrency
//
//  Created by 김건우 on 2/5/24.
//

import UIKit

class ConcurrencyViewController: UIViewController {

    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentTime = Date()
        
        // ⭐️작업이 병렬(Concurrent)로 수행됨
        Task(priority: .background) {
            do {
                async let image1 = loadImage(size: 300)
                async let image2 = loadImage(size: 300)
                imageView1.image = try await image1
                imageView2.image = try await image2
                
                print("소요 시간: \(Date().timeIntervalSince(currentTime))")
            } catch MyErrors.noImageData { debugPrint("이미지 가져오기 실패") }
        }
        
    }
    
    func loadImage(size: Int) async throws -> UIImage? {
        let imageUrl = URL(string: "https://source.unsplash.com/random/\(size)×\(size)")!
        
        if !Task.isCancelled {
            let imageTask = Task(priority: .background) { () -> UIImage? in
                do {
                    let (imageData, _) = try await URLSession.shared.data(from: imageUrl)
                    debugPrint("이미지 가져오기 성공: \(imageData)")
                    return UIImage(data: imageData)
                } catch { throw MyErrors.noImageData }
            }
            
            let result = await imageTask.result
            return try result.get()
        }
        
        return nil
    }

}
