//
//  DimmverViewController.swift
//  BeyondChallenge
//
//  Created by Günter Hertz on 09/03/19.
//  Copyright © 2019 Günter Hertz. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxGesture

class DimmerViewController: UIViewController {
    
    let disposedBag: DisposeBag = DisposeBag()
    let service: CommunicationService
    
    init(service: CommunicationService) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let view = DimmerView()
        
        view.dimmer.rx.
        view.dimmer.rx
            .value.subscribe(onNext: { value in
                let integerValue = Int(value)
                self.service.publishValue(value: integerValue)
            }).disposed(by: disposedBag)
        
        
        view.doneButton.rx
            .tap
            .subscribe(onNext: {
                self.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposedBag)
        
        view.blurView.rx
            .tapGesture()
            .when(.recognized)
            .subscribe({ _ in
                self.dismiss(animated: true, completion: nil)
            }).disposed(by: disposedBag)
        
        self.view = view
    }
}
