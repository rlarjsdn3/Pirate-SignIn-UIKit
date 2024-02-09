//
//  ActorViewController.swift
//  Concurrency
//
//  Created by 김건우 on 2/5/24.
//

import UIKit

// ⭐️ 데이터 레이스(Data Race)를 막아주도록 도와주는 클래스
// (단, class가 아닌 actor 키워드를 사용해야 함)
actor ItemData {
    var name: String
    var counter: Int
    
    init(name: String) {
        self.name = name
        self.counter = 0
    }
    
    func changeName(newName: String) {
        name = newName
        counter += 1
    }
}

class ActorViewController: UIViewController {
    var item: ItemData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        item = ItemData(name: "Undefined")
        
        Task(priority: .background) {
            async let imageName1 = loadImage(name: "potatos")
            async let imageName2 = loadImage(name: "milk")
            async let imageName3 = loadImage(name: "orange")
            
            let listNames = await "\(imageName1), \(imageName2), \(imageName3)"
            print(listNames)
        }
    }
    
    func loadImage(name: String) async -> String {
        // 클래스에 정의된 모든 프로퍼티와 메서드는 비동기(await)로 접근해야 함.
        await item.changeName(newName: name)
        
        let count = await item.counter
        return "\(name) \(count)"
    }

}
