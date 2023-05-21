//
//  UsersTableViewCell.swift
//  CKTest
//
//  Created by Muhammad Wahab on 21/05/2023.
//

import UIKit

class UsersTableViewCell: UITableViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var imgVwUser: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    
    
    //MARK: - Constansts and Variables
    
    //MARK: - View Controller LifeCycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - @OBJC Methods
    
    //MARK: - IBActions
    
    
    //MARK: - Custom Methods
    func setupCell(user: UserListingElement)
    {
        lblName.text = user.login ?? ""
        lblDetail.text = user.url ?? ""
        
        if let image = user.avatarURL
        {
            imgVwUser.setImageWithAlomofire(withUrl: URL(string: image)!, andPlaceholder: .ProfileImage())
        }
        else
        {
                imgVwUser.image = .ProfileImage()
        }
    }
}


