//
//  TaskGroupViewController.swift
//  Concurrency
//
//  Created by 김건우 on 2/5/24.
//

import UIKit

class TaskGroupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Task(priority: .background) {
            try await withThrowingTaskGroup(of: String.self) { group in
                group.addTask(priority: .background) {
                    let imageName = try? await self.loadImage(name: "image1")
                    return imageName ?? ""
                }
                group.addTask(priority: .background) {
                    let imageName = try? await self.loadImage(name: "image2")
                    return imageName ?? ""
                }
                group.addTask(priority: .background) {
                    let imageName = try? await self.loadImage(name: "image3")
                    return imageName ?? ""
                }
                for try await result in group {
                    print(result)
                }
            }
        }
    }
    
    func loadImage(name: String) async throws -> String {
        try await Task.sleep(nanoseconds: 3 * 1_000_000_000)
        return "Name: \(name)"
    }
}
