//
//  SearchResultsTableViewCell.swift
//  StreamFusion
//
//  Created by Lautaro Galan on 04/02/2024.
//

import UIKit

class SearchResultsTableViewCell: UITableViewCell {
    static let identifier = "SearchCell"
    private let resultQueryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 24)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        self.contentView.addSubview(resultQueryLabel)
        resultQueryLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            resultQueryLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            resultQueryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            resultQueryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            resultQueryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)

        ])
    }
}
