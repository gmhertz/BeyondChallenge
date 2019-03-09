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
    let service = CommunicationService()
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
        
        service.connectionStatus
            .bind(to: view.connectionStatus.rx.isOn)
            .disposed(by:disposedBag)
        
        //TO DO: error handling
//        service
//            .errorHandler
//            .subscribe({ returnCode in
//                print(returnCode.debugDescription)
//            })
//            .disposed(by: disposedBag)
        
        service.connect()
        self.view = view
    }
}
