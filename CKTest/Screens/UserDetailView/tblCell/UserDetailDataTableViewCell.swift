//
//  UserDetailDataTableViewCell.swift
//  CKTest
//
//  Created by Muhammad Wahab on 21/05/2023.
//

import UIKit

class UserDetailDataTableViewCell: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var lblValue: UILabel!
    
    
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
    func setupCell(user: UserDetailModel, index: Int)
    {
        
        switch index
        {
        case 0:
            lblHeading.text = "Name: "
            lblValue.text = user.name ?? "N/A"
        case 1:
            lblHeading.text = "Company: "
            lblValue.text = user.company ?? "N/A"
        case 2:
            lblHeading.text = "Blog: "
            lblValue.text = user.blog ?? "N/A"
        case 3:
            lblHeading.text = "Location: "
            lblValue.text = user.location ?? "N/A"
        case 4:
            lblHeading.text = "Public Repos: "
            lblValue.text = "\(user.publicRepos ?? 0)"
            
        case 5:
            lblHeading.text = "Public Gists: "
            lblValue.text = "\(user.publicGists ?? 0)"
            
        default:
            lblHeading.text = ""
            lblValue.text = ""
        }
        
    }
    
}
