//
//  InProgressDetailsProjectView.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 19/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class InProgressProjectDetailsView: UIView {
    
    private unowned var closeButton: UIButton
    private unowned var moreInfoButton: UIButton
    private unowned var participantsCollectionView: UICollectionView
    private unowned var participateRequestButton: UIButton
    
    private lazy var pictureImageView: UIImageView = {
        return UIImageView(frame: .zero)
    }()
    
    private lazy var titleLbl: UILabel = {
        return UILabel(frame: .zero)
    }()
    
    private lazy var containerView: UIView = {
        return UIView(frame: .zero)
    }()
    
    private lazy var descriptionLbl: UILabel = {
        return UILabel(frame: .zero)
    }()
    
    private lazy var teamLbl: UILabel = {
        return UILabel(frame: .zero)
    }()
    
    private lazy var needingLbl: UILabel = {
        return UILabel(frame: .zero)
    }()
    
    init(frame: CGRect,
         closeButton: UIButton,
         moreInfoButton: UIButton,
         participantsCollectionView: UICollectionView,
         participateRequestButton: UIButton) {
        self.closeButton = closeButton
        self.moreInfoButton = moreInfoButton
        self.participantsCollectionView = participantsCollectionView
        self.participateRequestButton = participateRequestButton
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension InProgressProjectDetailsView: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(46)
            make.right.equalToSuperview().inset(35)
            make.height.equalTo(31)
            make.width.equalTo(32)
        }
        pictureImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(77)
            make.centerX.equalToSuperview()
            make.height.equalTo(82)
            make.width.equalTo(84)
        }
    }
    
    func setupConstraints() {
        
    }
}
