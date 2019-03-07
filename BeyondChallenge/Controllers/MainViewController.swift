//
//  MainViewController.swift
//  BeyondChallenge
//
//  Created by Günter Hertz on 07/03/19.
//  Copyright © 2019 Günter Hertz. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class MainViewController: UIViewController {
    let disposedBag: DisposeBag = DisposeBag()
    
    override func loadView() {
        let view = MainView(frame: UIScreen.main.bounds)
        
        //Need to make bind here before set FirstScreen as View or find a better way
        view.updateButton.rx.tap
            .bind {
                print("update button did tap do some action")
            }
            .disposed(by: disposedBag)
        
        view.connectionStatus.rx
            .isOn
            .subscribe { status in
                print("switch status: \(status)")
            }
            .disposed(by: disposedBag)
        
        self.view = view
    }
}
