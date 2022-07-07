//
//  ProfileHeaderView.swift
//  navigation
//
//  Created by Сергей Марсалов on 05.07.2022.
//

import UIKit

class ProfileHeaderView: UIView {
    lazy var avatarImage: UIImageView = {
        let avatar = UIImageView(frame: CGRect(x: 16, y:  104, width: 100, height: 100))
        avatar.clipsToBounds = true
        avatar.layer.cornerRadius = avatar.frame.width / 2
        avatar.layer.borderWidth = 3
        avatar.layer.borderColor = UIColor.black.cgColor
        avatar.image = UIImage(named: "avatar.jpg")
        return avatar
    }()
    
    lazy var  nameLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 140, y: 115, width: 140, height: 30))
        label.text = "Angoric"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    lazy var status: UILabel = {
        let status = UILabel(frame: CGRect(x: 150, y: 156, width: 140, height: 30))
        status.text = "У меня лапки!"
        status.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        status.textColor = UIColor.gray
        return status
    }()
    
    lazy var button :UIButton = {
        let btn = UIButton(frame: CGRect(x: 16, y: 238, width: 343, height: 50))
        btn.setTitle("Show status", for: .normal)
        btn.backgroundColor = .systemBlue
        btn.layer.cornerRadius = 14
        btn.layer.shadowRadius = 4
        btn.layer.shadowOffset.width = 4
        btn.layer.shadowOffset.height = 4
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOpacity = 0.7
        btn.addTarget(self, action: #selector(printStatus), for: .touchUpInside)
        return btn
    }()
    
    @objc func printStatus() {
        print(status.text)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(button)
        self.addSubview(nameLabel)
        self.addSubview(avatarImage)
        self.addSubview(status)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
