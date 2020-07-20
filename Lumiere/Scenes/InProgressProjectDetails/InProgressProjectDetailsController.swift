//
//  InProgressProjectDetailsController.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 19/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class InProgressProjectDetailsController: BaseViewController {
    
    private lazy var closeButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        return view
    }()
    
    private lazy var participantsCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero)
        view.delegate = self
        view.dataSource = self
        view.registerCell(cellType: TeamMemberCollectionViewCell.self)
        return view
    }()
    
    private lazy var moreInfoButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapMoreInfoButton), for: .touchUpInside)
        return view
    }()
    
    private lazy var participateRequestButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.addTarget(self, action: #selector(didTapParticipateRequestButton), for: .touchUpInside)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
    }
}

extension InProgressProjectDetailsController: UICollectionViewDelegate {
    
}

extension InProgressProjectDetailsController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}

extension InProgressProjectDetailsController: UICollectionViewDelegateFlowLayout {
    
}

extension InProgressProjectDetailsController {
    
    @objc
    private func didTapCloseButton() {
        
    }
    
    @objc
    private func didTapMoreInfoButton() {
        
    }
    
    @objc
    private func didTapParticipateRequestButton() {
        
    }
}
