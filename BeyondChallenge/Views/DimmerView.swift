//
//  DimmerView.swift
//  BeyondChallenge
//
//  Created by Günter Hertz on 07/03/19.
//  Copyright © 2019 Günter Hertz. All rights reserved.
//

import SnapKit
import UIKit

class DimmerView: UIView {

    lazy var blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let bluerEffectView = UIVisualEffectView(effect: blurEffect)
        bluerEffectView.alpha = 0.5
        bluerEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        return bluerEffectView
    }()
    
    lazy var dimmer: UISlider = {
        let slider = UISlider(frame: .zero)
        slider.maximumValue = 100
        slider.minimumValue = 0
        slider.value = 0
        slider.isContinuous = true
        slider.tintColor = .orange
        slider.thumbTintColor = .orange
        slider.minimumValueImage = UIImage(named: "lamp_turnOff")
        slider.maximumValueImage = UIImage(named: "lamp_turnOn")
        
        return slider
    }()
    
    lazy var dimmerLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Dimmer"
        label.textColor = .white
        label.font = label.font.withSize(20)
        
        return label
    }()
    
    lazy var doneButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Pronto", for: .normal)
        button.titleLabel?.font = button.titleLabel?.font.withSize(20)
        
        return button
    }()
    
    lazy var cardView: UIView = {
        let view = UIView(frame: .zero)
        view.layer.cornerRadius = 10
        view.backgroundColor = .darkGray
        
        view.addSubview(dimmerLabel)
        view.addSubview(dimmer)
        view.addSubview(doneButton)
        
        return view
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)

        viewSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DimmerView: CodeView {
    func viewHierarchy() {
        addSubview(blurView)
        addSubview(cardView)
    }
    
    func viewConstraints() {

        blurView.snp.makeConstraints{
            $0.center.equalToSuperview()
            $0.left.equalToSuperview()
            $0.top.equalToSuperview()
        }
  
        cardView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.left.equalToSuperview().offset(20)
            $0.height.equalTo(150)
        }
        
        dimmerLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(15)
            $0.top.equalToSuperview().offset(15)
        }
        
        dimmer.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.left.equalToSuperview().offset(15)

        }
        doneButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(15)
            $0.left.equalToSuperview().offset(15)
        }
    }
    
    func viewAdditionalConfiguration() {
        backgroundColor = .clear
    }
}
