//
//  UserDetailViewController.swift
//  CKTest
//
//  Created by Muhammad Wahab on 21/05/2023.
//

import UIKit

class UserDetailViewController: BaseViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var imgVwUser: UIImageView!
    @IBOutlet weak var lblFollower: UILabel!
    @IBOutlet weak var lblFollowing: UILabel!
    @IBOutlet weak var tblUserDetailData: UITableView!
    
    
    // MARK: - Variables & Constants

    
    var viewModel:  UserDetailViewModel! {
        didSet {
            super.baseViewModel = viewModel
        }
    }
    
    // MARK: - UIViewController Initializer
    
    init(viewModel: UserDetailViewModel) {
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
    
    // MARK: - UIViewController Helper Methods
    
    override func setupViewController()  {
        viewModel.delegate = self
        
        //tableView
        tblUserDetailData.registerCell(class: UserDetailDataTableViewCell.self)
        tblUserDetailData.delegate = self
        tblUserDetailData.dataSource = self
        
        //labels
        lblFollower.clipsToBounds = true
        lblFollowing.clipsToBounds = true
        lblFollower.layer.cornerRadius = 10
        lblFollowing.layer.cornerRadius = 10
        
    }
    
    override func setupNavigationBarUI() {
        navigationItem.title = ""
    }
    
    func feedView()
    {
        
        navigationItem.title = viewModel.userDet?.name ?? ""
        if let image = viewModel.userDet?.avatarURL
        {
            imgVwUser.setImageWithAlomofire(withUrl: URL(string: image)!, andPlaceholder: .ProfileImage())
        }
        else
        {
                imgVwUser.image = .ProfileImage()
        }
        lblFollower.text = String(format: "Followers: %d", viewModel.userDet?.followers ?? 0)
        lblFollowing.text = String(format: "Following: %d", viewModel.userDet?.following ?? 0)
        tblUserDetailData.reloadData()
        
    }
    
    
    // MARK: - Selectors
    
    // MARK: - IBActions
    
    // MARK: - Private Methods
}
// MARK: - UserDetailViewModelDelegate
extension UserDetailViewController:  UserDetailViewModelDelegate {
    
    func updateView() {
        self.feedView()
    }
}


// MARK: - UITableViewDelegate,UITableViewDataSource
extension UserDetailViewController:  UITableViewDelegate,UITableViewDataSource {
 
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _ = viewModel.userDet
        {
            return 6
        }
        else
        {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: UserDetailDataTableViewCell = tableView.dequeueReusableCell(withIdentifier: "UserDetailDataTableViewCell", for: indexPath) as? UserDetailDataTableViewCell
        {
            cell.setupCell(user: viewModel.userDet!,index: indexPath.row)
            return cell
        }
        else
        {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
