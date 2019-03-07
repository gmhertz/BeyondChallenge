//
//  MainView.swift
//  BeyondChallenge
//
//  Created by Günter Hertz on 07/03/19.
//  Copyright © 2019 Günter Hertz. All rights reserved.
//
import SnapKit
import UIKit

class MainView: UIView {
    //Declare elements of the screen
    lazy var image: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.backgroundColor = .orange
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    lazy var updateButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Atualizar", for: .normal)
        button.titleLabel?.font.withSize(18)
        button.backgroundColor = .blue
        
        button.layer.cornerRadius = 10.0
        button.layer.borderWidth = 3.0
        
        return button
    }()
    
    lazy var connectionText: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Conectado"
        label.textAlignment = .left
        label.textColor = .white
        label.backgroundColor = .black
        //        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.font.withSize(20)
        
        return label
    }()
    
    lazy var connectionStatus: UISwitch = {
        let connectionStatus = UISwitch(frame: .zero)
        return connectionStatus
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.addArrangedSubview(connectionText)
        stack.addArrangedSubview(connectionStatus)
        stack.backgroundColor = .red
        stack.spacing = 10
        stack.alignment = .center
        stack.distribution = .fill
        stack.axis = .horizontal
        
        return stack
    }()
    
    
    //init functions
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("This should not happen - init(coder:) has not been implemented")
    }
}

extension MainView: CodeView {
    func viewHierarchy() {
        addSubview(image)
        addSubview(updateButton)
        addSubview(stackView)
    }
    
    func viewConstraints() {
        image.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.left.equalToSuperview().offset(50)
            $0.top.equalToSuperview().offset(50)
            $0.height.equalTo(200)
        }
        
        stackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.left.equalToSuperview().offset(50)
            $0.top.equalTo(image.snp.bottom).offset(60)
        }
        
        //define elements inside the stack view
        connectionText.snp.makeConstraints {
            $0.centerY.equalTo(stackView.snp.centerY)
            $0.top.equalTo(stackView.snp.top)
        }
        connectionStatus.snp.makeConstraints {
            $0.centerY.equalTo(stackView.snp.centerY)
        }
        
        updateButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(50)
            $0.left.equalToSuperview().offset(40)
            $0.height.equalTo(40)
        }
    }
    
    func viewAdditionalConfiguration() {
        backgroundColor = .darkGray
    }
    
}
