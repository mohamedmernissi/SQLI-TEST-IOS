//
//  UserCell.swift
//  SQLI-TEST
//
//  Created by mohamed mernissi on 5/11/2022.
//

import SnapKit
import SDWebImage

class UserCell: UITableViewCell {
    
    private let containerView: UIView = UIView()
    
    private let nameLabel: UILabel = UILabel()
    
    private let avatarImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()
    
    private let emailLabel: UILabel = UILabel()
    
    func setupViews() {
        contentView.addSubview(containerView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(emailLabel)
        containerView.addSubview(avatarImage)
        setupConstraints()
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        avatarImage.snp.makeConstraints { make in
            make.width.height.equalTo(120)
            make.top.equalTo(8)
            make.bottom.equalTo(-8)
            make.left.equalTo(16)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImage.snp.top)
            make.left.equalTo(avatarImage.snp.right).offset(8)
            make.right.equalTo(-8)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.left.equalTo(avatarImage.snp.right).offset(8)
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.right.equalTo(-8)
        }
    }
    
    func bind(user: UserViewModel) {
        nameLabel.text = user.fullName
        avatarImage.sd_setImage(with: user.avatar)
        emailLabel.text = user.email
    }
}
