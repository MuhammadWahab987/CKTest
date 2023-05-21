//
//  UsersListingViewViewModel.swift
//  CKTest
//
//  Created by Muhammad Wahab on 21/05/2023.
//

import Foundation

protocol UsersListingViewModelDelegate: BaseViewModelDelegate {
    func updateView(isSuccessFullAPIResponse: Bool)
}

class UsersListingViewModel: BaseViewModel {
    
    //MARK: - Constansts and Variables
    var userListing:UsersListingModel = []
    var offSet = 0
    weak var delegate: UsersListingViewModelDelegate? {
        didSet {
            super.baseDelegate = delegate
        }
    }
    
    
    //MARK: - @OBJC Methods
    
    
    
    //MARK: - Custom Methods
    func loadData() {
        let request = UsersListingRequest()
        request.offset = offSet
        
        delegate?.showPorgress()
        APIClient.shared.fetchDataWithRequest(request: request) { [weak self] (response) in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                
                
                self.delegate?.hideProgress()
                
                if response.success {
                    
                    if let userListing = response.data as? UsersListingModel
                    {
                        if self.offSet == 0
                        {
                            self.userListing = userListing
                        }
                        else
                        {
                            self.userListing.append(contentsOf: userListing)
                        }
                        self.delegate?.updateView(isSuccessFullAPIResponse: true)
                    }
                    else {
                        AlertBuilder.showBannerBelowNavigation(message: "error while parsing data")
                        self.delegate?.updateView(isSuccessFullAPIResponse: false)
                    }
                    
                } else {
                    AlertBuilder.showBannerBelowNavigation(message: response.message)
                    self.delegate?.updateView(isSuccessFullAPIResponse: false)
                }
            }
        }
    }
    
}
