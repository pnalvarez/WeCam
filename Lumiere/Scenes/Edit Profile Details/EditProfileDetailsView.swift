//
//  EditProfileDetailsView.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 23/08/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit
import SDWebImage

class EditProfileDetailsView: BaseView {
    
    private unowned var finishButton: UIButton
    private unowned var imageButton: UIButton
    private unowned var nameTextField: UITextField
    private unowned var cellphoneTextField: UITextField
    private unowned var ocupationTextField: UITextField
    private unowned var collectionView: UICollectionView
    
    private lazy var containerView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.showsVerticalScrollIndicator = false
        view.bounces = false
        view.alwaysBounceVertical = false
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var titleLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = EditProfileDetails.Constants.Texts.titleLBl
        view.textColor = EditProfileDetails.Constants.Colors.titleLbl
        view.font = EditProfileDetails.Constants.Fonts.titleLbl
        view.textAlignment = .center
        return view
    }()
    
    private lazy var changeImageLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = EditProfileDetails.Constants.Texts.changeImageLbl
        view.textColor = EditProfileDetails.Constants.Colors.changeImageLbl
        view.font = EditProfileDetails.Constants.Fonts.changeImageLbl
        view.textAlignment = .center
        return view
    }()
    
    private lazy var cathegoriesLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.attributedText = NSAttributedString(string: EditProfileDetails.Constants.Texts.cathegoriesLbl,
                                                 attributes: [NSAttributedString.Key.foregroundColor: EditProfileDetails.Constants.Colors.cathegoriesLbl, NSAttributedString.Key.font: EditProfileDetails.Constants.Fonts.cathegoriesLbl, NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
        return view
    }()
    
    private lazy var bottomView: UIView = {
        let view = UIView(frame: .zero)
        return view
    }()
    
    private var viewModel: EditProfileDetails.Info.ViewModel.User?
    
    init(frame: CGRect,
         finishButton: UIButton,
         imageButton: UIButton,
         nameTextField: UITextField,
         cellphoneTextField: UITextField,
         ocupationTextField: UITextField,
         collectionView: UICollectionView) {
        self.finishButton = finishButton
        self.imageButton = imageButton
        self.nameTextField = nameTextField
        self.cellphoneTextField = cellphoneTextField
        self.ocupationTextField = ocupationTextField
        self.collectionView = collectionView
        super.init(frame: frame)
        applyViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(viewModel: EditProfileDetails.Info.ViewModel.User) {
        self.viewModel = viewModel
        applyViewCode()
    }
}

extension EditProfileDetailsView {
    
    func updateAllTextFields() {
        for view in allSubviews {
            if let textField = view as? WCInputTextField {
                if let isEmpty = textField.text?.isEmpty {
                    if isEmpty {
                        textField.textFieldState = .error
                    } else {
                        textField.textFieldState = .normal
                    }
                }
            }
        }
    }
}

extension EditProfileDetailsView: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        containerView.addSubview(titleLbl)
        containerView.addSubview(finishButton)
        containerView.addSubview(imageButton)
        containerView.addSubview(changeImageLbl)
        containerView.addSubview(nameTextField)
        containerView.addSubview(cellphoneTextField)
        containerView.addSubview(ocupationTextField)
        containerView.addSubview(cathegoriesLbl)
        containerView.addSubview(collectionView)
        containerView.addSubview(bottomView)
        scrollView.addSubview(containerView)
        addSubview(scrollView)
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().priority(250)
        }
        titleLbl.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(8)
            make.centerX.equalToSuperview()
            make.width.equalTo(84)
        }
        finishButton.snp.makeConstraints { make in
            make.top.equalTo(titleLbl)
            make.right.equalToSuperview().inset(30)
            make.height.equalTo(19)
            make.width.equalTo(64)
        }
        imageButton.snp.makeConstraints { make in
            make.top.equalTo(titleLbl.snp.bottom).offset(56)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(84)
        }
        changeImageLbl.snp.makeConstraints { make in
            make.top.equalTo(imageButton.snp.bottom).offset(17)
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
        }
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(changeImageLbl.snp.bottom).offset(26)
            make.left.right.equalToSuperview().inset(40)
            make.height.equalTo(29)
        }
        cellphoneTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(26)
            make.left.right.equalToSuperview().inset(40)
            make.height.equalTo(29)
        }
        ocupationTextField.snp.makeConstraints { make in
            make.top.equalTo(cellphoneTextField.snp.bottom).offset(26)
            make.left.right.equalToSuperview().inset(40)
            make.height.equalTo(29)
        }
        cathegoriesLbl.snp.makeConstraints { make in
            make.top.equalTo(ocupationTextField.snp.bottom).offset(56)
            make.centerX.equalToSuperview()
            make.width.equalTo(176)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLbl.snp.bottom).offset(450)
            make.height.equalTo(650)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(30)
        }
    }
    
    func configureViews() {
        backgroundColor = .white
        scrollView.contentSize = CGSize(width: frame.width, height: 975)
        nameTextField.text = viewModel?.name
        cellphoneTextField.text = viewModel?.cellphone
        ocupationTextField.text = viewModel?.ocupation
        guard let image = viewModel?.image else { return }
        imageButton.sd_setImage(with: URL(string: image), for: .normal, completed: nil)
    }
}
