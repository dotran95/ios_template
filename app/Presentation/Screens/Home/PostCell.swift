//
//  PostCell.swift
//  app
//
//  Created by VTIT on 19/8/24.
//

import UIKit

class PostCell: UITableViewCell, ViewProtocol {

    static let identifier = "PostCell"

    var titleLbl: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 17)
        lb.numberOfLines = 0
        return lb
    }()

    var postIdLbl: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 17)
        lb.numberOfLines = 0
        return lb
    }()

    var tagsLbl: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 13)
        lb.numberOfLines = 0
        return lb
    }()

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        makeUI()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        makeUI()
    }

    func makeUI() {

        addSubview(postIdLbl)
        addSubview(titleLbl)
        addSubview(tagsLbl)

        postIdLbl.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(self.snp.horizontalEdges).offset(12)
            make.top.equalTo(self).offset(12)
        }

        titleLbl.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(self.snp.horizontalEdges).offset(12)
            make.top.equalTo(postIdLbl.snp.bottom).offset(4)
        }

        tagsLbl.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(self.snp.horizontalEdges).offset(12)
            make.top.equalTo(titleLbl.snp.bottom).offset(4)
            make.bottom.equalTo(self).offset(-12)
        }
    }

    func updateUI() { }

}
