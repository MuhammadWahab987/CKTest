//
//  UserDetailViewModel.swift
//  CKTest
//
//  Created by Muhammad Wahab on 21/05/2023.
//

import Foundation

protocol UserDetailViewModelDelegate: BaseViewModelDelegate {
    func updateView()
}

class UserDetailViewModel: BaseViewModel {
    
    
    //MARK: - Constansts and Variables
    var userName = ""
    var userDet : UserDetailModel?
    weak var delegate: UserDetailViewModelDelegate? {
        didSet {
            super.baseDelegate = delegate
        }
    }
    
    
    //MARK: - @OBJC Methods
    
    
    
    //MARK: - Custom Methods
    func loadData() {
        let request = UserDetailRequest()
        request.userName = self.userName
        delegate?.showPorgress()
        APIClient.shared.fetchDataWithRequest(request: request) { [weak self] (response) in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                
                
                self.delegate?.hideProgress()
                
                if response.success {
                    if let useDetMod = response.data as? UserDetailModel
                    {
                        self.userDet = useDetMod
                        self.delegate?.updateView()
                    }
                    else {
                        AlertBuilder.showBannerBelowNavigation(message: "error while parsing data")
                    }
                    
                } else {
                    AlertBuilder.showBannerBelowNavigation(message: response.message)
                }
                
            }
        }
    }
}
