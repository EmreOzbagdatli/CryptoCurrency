//
//  TableViewCell.swift
//  KriptoParaUygulamasi
//
//  Created by Emre Özbağdatlı on 21.10.2023.
//

import UIKit

class TableViewCell: UITableViewCell {

    static let identifier = "CustomCell"
    
    private let currencyLabel : UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 24,weight: .bold)
        return label
    }()
    
    private let priceLabel : UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 24,weight: .medium)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public func configure(with currencyLbl: String,with priceLbl: String){
        self.currencyLabel.text = currencyLbl
        self.priceLabel.text = priceLbl
    }
    private func setupUI(){
        
        self.contentView.addSubview(currencyLabel)
        self.contentView.addSubview(priceLabel)
        
        currencyLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            currencyLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            currencyLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 16),
            currencyLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: -8),
            currencyLabel.heightAnchor.constraint(equalToConstant: 45),
            
            priceLabel.topAnchor.constraint(equalTo: self.currencyLabel.bottomAnchor,constant: 16),
            priceLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 16),
            priceLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: -8),
            priceLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
            
        ])
        
    }
}
