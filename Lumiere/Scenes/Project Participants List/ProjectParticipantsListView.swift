//
//  ProjectParticipantsListView.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 05/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit
import WCUIKit

class ProjectParticipantsListView: BaseView, ModalViewable {
    
    private unowned var tableView: UITableView
    
    private lazy var participantsFixedLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = ProjectParticipantsList.Constants.Texts.participantsFixedLbl
        view.font = ProjectParticipantsList.Constants.Fonts.participantsFixedLbl
        view.textColor = ProjectParticipantsList.Constants.Colors.participantsFixedLbl
        view.textAlignment = .left
        view.numberOfLines = 0
        return view
    }()
    
    init(frame: CGRect,
         tableView: UITableView) {
        self.tableView = tableView
        super.init(frame: frame)
        applyViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProjectParticipantsListView: ViewCodeProtocol {
    
    func buildViewHierarchy() {
        addSubview(participantsFixedLbl)
        addSubview(tableView)
    }
    
    func setupConstraints() {
        participantsFixedLbl.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(48)
            make.left.equalToSuperview().inset(46)
            make.width.equalTo(191)
            make.height.equalTo(22)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(participantsFixedLbl.snp.bottom).offset(20)
            make.left.right.bottom.equalToSuperview()
        }
    }
}
