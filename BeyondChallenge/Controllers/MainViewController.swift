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
        let view = MainView()
        
        //Need to make bind here before set FirstScreen as View or find a better way
        view.updateButton.rx.tap
            .subscribe(onNext: {
                print("update button did tap do some action")
                let dimmerVC = DimmerViewController()
                dimmerVC.modalPresentationStyle = .overCurrentContext
                self.present(dimmerVC, animated: true, completion: nil)
            })
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
