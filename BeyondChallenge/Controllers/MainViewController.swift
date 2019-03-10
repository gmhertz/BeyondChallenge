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
                let dimmerVC = DimmerViewController(service: self.service)
                dimmerVC.modalPresentationStyle = .overCurrentContext
                self.present(dimmerVC, animated: true, completion: nil)
            })
            .disposed(by: disposedBag)
        
        service.connectionStatus
            .bind(to: view.connectionStatus.rx.isOn)
            .disposed(by:disposedBag)
        
        service
            .dimmerValue
            .map { $0 < 50 ? true : false }
            .bind(to: view.image.rx.isHidden)
            .disposed(by: disposedBag)
        
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
