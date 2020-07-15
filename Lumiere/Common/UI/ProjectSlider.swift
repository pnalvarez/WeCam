//
//  ProjectSlider.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 15/07/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class ProjectSlider: UISlider {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setThumbImage(ProjectSteps.Constants.Images.stepSliderNormal, for: .normal)
//        setMinimumTrackImage(ProjectSteps.Constants.Images.stepSliderMinimum, for: .normal)
//        setMaximumTrackImage(ProjectSteps.Constants.Images.stepSliderMaximum, for: .normal)
        setThumbImage(ProjectSteps.Constants.Images.stepSliderNormal, for: .highlighted)
//        setMinimumTrackImage(ProjectSteps.Constants.Images.stepSliderMinimum, for: .highlighted)
//        setMaximumTrackImage(ProjectSteps.Constants.Images.stepSliderMaximum, for: .highlighted)
        backgroundColor = .white
        layer.borderWidth = 1
        layer.borderColor = UIColor(rgb: 0xe0e0e0).cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.minX, y: bounds.minY, width: bounds.width, height: 11)
    }
}
