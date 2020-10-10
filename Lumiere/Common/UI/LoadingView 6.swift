//
//  LoadingView.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 16/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    
    private let movieLogo = UIImage(named: "logo-apenas")
    private let loadingLogo = UIImage(named: "Loading...")
    
    private lazy var movieImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFit
        view.image = movieLogo
        return view
    }()
    
    private lazy var loadingImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleToFill
        view.image = loadingLogo
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        applyViewCode()
//        animateRotate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        movieImageView.layer.cornerRadius = movieImageView.frame.height / 2
        movieImageView.clipsToBounds = true
    }

    func animateRotate() {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 1
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        movieImageView.layer.add(rotation, forKey: "rotationAnimation")
    }
}

extension LoadingView: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        addSubview(movieImageView)
        addSubview(loadingImageView)
    }
    
    func setupConstraints() {
        movieImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(131)
        }
        loadingImageView.snp.makeConstraints { make in
            make.top.equalTo(movieImageView.snp.bottom)
            make.centerX.equalToSuperview()
            make.height.equalTo(46)
        }
    }
    
    func configureViews() {
        backgroundColor = .white
    }
}