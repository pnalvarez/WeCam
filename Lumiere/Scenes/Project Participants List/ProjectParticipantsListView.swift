//
//  ProjectParticipantsListView.swift
//  Lumiere
//
//  Created by Pedro Alvarez on 05/09/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class ProjectParticipantsListView: UIView {
    
    private unowned var closeButton: DefaultCloseButton
    private unowned var tableView: UITableView
    
    private lazy var participantsFixedLbl: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = ProjectParticipantsList.Constants.Texts.participantsFixedLbl
        view.font = ProjectParticipantsList.Constants.Fonts.participantsFixedLbl
        view.textColor = ProjectParticipantsList.Constants.Colors.participantsFixedLbl
        view.textAlignment = .left
        return view
    }()
    
    init(frame: CGRect,
         closeButton: DefaultCloseButton,
         tableView: UITableView) {
        self.closeButton = closeButton
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
        addSubview(closeButton)
        addSubview(participantsFixedLbl)
        addSubview(tableView)
    }
    
    func setupConstraints() {
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(44)
            make.right.equalToSuperview().inset(54)
            make.height.equalTo(31)
            make.width.equalTo(32)
        }
        participantsFixedLbl.snp.makeConstraints { make in
            make.top.equalTo(closeButton.snp.bottom).offset(8)
            make.left.equalToSuperview().inset(46)
            make.width.equalTo(191)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(participantsFixedLbl.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
}
