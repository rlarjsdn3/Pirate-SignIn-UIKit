//
//  MainActorViewController.swift
//  Concurrency
//
//  Created by 김건우 on 2/5/24.
//

import UIKit

class MainActorViewController: UIViewController {
    @IBOutlet weak var myLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Task(priority: .background) {
            await loadImage(name: "image1")
        }
    }
    
    // ⭐️ 메서드에 포함된 코드가 메인 쓰레드에서 실행되는 걸 보장해줌
    @MainActor func loadImage(name: String) async {
//        myLabel.text = name
        // ⭐️ 전체 코드 중 일부만 메인 쓰레드에서 실행되어야 한다면 run() 메서드 사용함
        let labelText: String = await MainActor.run {
            let text = myLabel.text
            return text ?? ""
        }
        print(labelText)
    }

}
