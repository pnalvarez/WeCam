//
//  ProjectStepsView.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 14/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import UIKit

class ProjectStepsView: UIView {
    
    private unowned var stepSlider: UISlider
    private unowned var advanceButton: UIButton
    
    private lazy var titleLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = ProjectSteps.Constants.Texts.titleLbl
        view.textAlignment = .center
        view.font = ProjectSteps.Constants.Fonts.titleLbl
        view.textColor = ProjectSteps.Constants.Colors.titleLbl
        view.adjustsFontSizeToFitWidth = true
        view.minimumScaleFactor = 0.5
        return view
    }()
    
    private lazy var zeroPercentLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = ProjectSteps.Constants.Texts.zeroPercentLbl
        view.textAlignment = .center
        view.font = ProjectSteps.Constants.Fonts.zeroPercentLbl
        view.textColor = ProjectSteps.Constants.Colors.zeroPercentLbl
        return view
    }()
    
    private lazy var hundredPercenteLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = ProjectSteps.Constants.Texts.hundredPercentLbl
        view.textAlignment = .center
        view.font = ProjectSteps.Constants.Fonts.hundredPercentLbl
        view.textColor = ProjectSteps.Constants.Colors.hundredPercentLbl
        return view
    }()
    
    init(frame: CGRect,
         stepSlider: UISlider,
         advanceButton: UIButton) {
        self.stepSlider = stepSlider
        self.advanceButton = advanceButton
        super.init(frame: frame)
        applyViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProjectStepsView: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        addSubview(advanceButton)
        addSubview(titleLbl)
        addSubview(stepSlider)
        addSubview(zeroPercentLbl)
        addSubview(hundredPercenteLbl)
    }
    
    func setupConstraints() {
        advanceButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(12)
            make.right.equalToSuperview().inset(28)
            make.width.equalTo(59)
        }
        titleLbl.snp.makeConstraints { make in
            make.top.equalTo(advanceButton.snp.bottom).offset(47)
            make.centerX.equalToSuperview()
            make.width.equalTo(187)
        }
        stepSlider.snp.makeConstraints { make in
            make.top.equalTo(titleLbl.snp.bottom).offset(154)
            make.left.right.equalToSuperview().inset(56)
            make.height.equalTo(11)
        }
        zeroPercentLbl.snp.makeConstraints { make in
            make.top.equalTo(stepSlider.snp.bottom).offset(83)
            make.left.equalTo(stepSlider.snp.left)
            make.width.equalTo(40)
            make.height.equalTo(19)
        }
        hundredPercenteLbl.snp.makeConstraints { make in
            make.top.equalTo(stepSlider.snp.bottom).offset(83)
            make.right.equalTo(stepSlider.snp.right)
            make.width.equalTo(40)
            make.height.equalTo(19)
        }
    }
    
    func configureViews() {
        backgroundColor = ProjectSteps.Constants.Colors.background
        
        stepSlider.tintColor = ProjectSteps.Constants.Colors.stepSliderBackground
        stepSlider.backgroundColor = ProjectSteps.Constants.Colors.advanceButton
        
        advanceButton.setAttributedTitle(NSAttributedString(string: ProjectSteps.Constants.Texts.advanceButton,
                                                            attributes: [NSAttributedString.Key.foregroundColor: ProjectSteps.Constants.Colors.advanceButton, NSAttributedString.Key.font: ProjectSteps.Constants.Fonts.advanceButton]), for: .normal)
    }
}
