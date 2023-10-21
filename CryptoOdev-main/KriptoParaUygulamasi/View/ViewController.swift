//
//  ViewController.swift
//  KriptoParaUygulamasi
//
//  Created by Atil Samancioglu on 21.10.2023.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    private let tableView: UITableView = {
       let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.allowsSelection = true
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        return tableView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    
    var cryptoList = [Crypto]()
    let disposeBag = DisposeBag()
    
    let cryptoVM = CryptoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupTableView()
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
        
        
        setupBindings()
        cryptoVM.requestData()
       
    }
    
    private func setupTableView(){
        self.view.backgroundColor = .orange
        
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
       
        
        
    }
    private func setupBindings() {
        
        cryptoVM
            .cryptos
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { [weak self] cryptos in
                self?.cryptoList = cryptos
                self?.tableView.reloadData()
            }.disposed(by: disposeBag)
        
        
        cryptoVM
            .error
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { error in
                print(error)
            }.disposed(by: disposeBag)
        
   
        cryptoVM
            .loading
            //.bind(to: self.activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        
        cryptoVM
            .loading
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { bool in
                print(bool)
            }.disposed(by: disposeBag)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell else {
            fatalError("Could not dequeue")
        }
        cell.configure(with: cryptoList[indexPath.row].currency, with: cryptoList[indexPath.row].price)
        return cell
        
        
        //        let cell = UITableViewCell()
        //        var content = cell.defaultContentConfiguration()
        //        content.text = cryptoList[indexPath.row].currency
        //        content.secondaryText = cryptoList[indexPath.row].price
        //        cell.contentConfiguration = content
        //        return cell
        
    }

}

