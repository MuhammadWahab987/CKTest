//
//  UsersListingViewViewController.swift
//  CKTest
//
//  Created by Muhammad Wahab on 21/05/2023.
//

import UIKit

class UsersListingViewController: BaseViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tblUsers: UITableView!
    
    
    
    // MARK: - Variables & Constants
    private let refreshControl = UIRefreshControl()
    var viewModel:  UsersListingViewModel! {
        didSet {
            super.baseViewModel = viewModel
        }
    }

    
    // MARK: - UIViewController Initializer
    
    init(viewModel: UsersListingViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIViewController Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        setupNavigationBarUI()
        
        viewModel.loadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    // MARK: - UIViewController Helper Methods
    
    override func setupViewController()  {
        viewModel.delegate = self
        
        //tableView
        tblUsers.registerCell(class: UsersTableViewCell.self)
        tblUsers.delegate = self
        tblUsers.dataSource = self
        tblUsers.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
    }
    
    override func setupNavigationBarUI() {
        navigationItem.title = "Github Users"
    }
    
    // MARK: - Selectors
    @objc private func refreshData(_ sender: Any) {
        viewModel.offSet = 0
        viewModel.loadData()
        
    }
    
    // MARK: - IBActions
    
    // MARK: - Private Methods
}

// MARK: - UsersListingViewViewModelDelegate
extension UsersListingViewController:  UsersListingViewModelDelegate {
    func updateView(isSuccessFullAPIResponse: Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if isSuccessFullAPIResponse
            {
                self.refreshControl.endRefreshing()
                self.tblUsers.reloadData()
            }
            else
            {
                self.refreshControl.endRefreshing()
            }
        }
    }
}

// MARK: - UITableViewDelegate,UITableViewDataSource
extension UsersListingViewController:  UITableViewDelegate,UITableViewDataSource {
 
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.userListing.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: UsersTableViewCell = tableView.dequeueReusableCell(withIdentifier: "UsersTableViewCell", for: indexPath) as? UsersTableViewCell
        {
            if indexPath.row == viewModel.userListing.count - 1
            {
                viewModel.offSet = indexPath.row
                viewModel.loadData()
            }
            
            cell.setupCell(user: viewModel.userListing[indexPath.row])
            return cell
        }
        else
        {
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        let userDetViewMod = UserDetailViewModel()
        userDetViewMod.userName = viewModel.userListing[indexPath.row].login ?? ""
        let userDetViewCon = UserDetailViewController(viewModel: userDetViewMod)
        userDetViewCon.addCustomBackButton(image: .BackIcon())
        self.navigationController?.pushViewController(userDetViewCon, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
