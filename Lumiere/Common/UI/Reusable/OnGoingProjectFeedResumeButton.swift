//
//  OnGoingProjectFeedResumeButton.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 17/10/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class OnGoingProjectFeedResumeButton: UIButton {
    
    private lazy var photoImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleToFill
        view.layer.cornerRadius = 42
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var progressView: UIProgressView = {
        let view = UIProgressView(progressViewStyle: .bar)
        view.progressTintColor = ThemeColors.mainRedColor.rawValue
        view.backgroundColor = .gray
        return view
    }()
    
    private var image: String
    private var progress: Float
    
    init(frame: CGRect,
         image: String,
         progress: Float) {
        self.image = image
        self.progress = progress
        super.init(frame: frame)
        applyViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OnGoingProjectFeedResumeButton: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        addSubview(photoImageView)
        addSubview(progressView)
    }
    
    func setupConstraints() {
        photoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.width.equalTo(84)
        }
        progressView.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(5)
            make.centerX.equalTo(photoImageView)
            make.left.right.equalToSuperview().inset(5)
        }
    }
    
    func configureViews() {
        backgroundColor = .white
        clipsToBounds = true
        photoImageView.sd_setImage(with: URL(string: image), completed: nil)
        progressView.progress = progress
    }
}
