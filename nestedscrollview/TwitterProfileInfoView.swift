import UIKit
import SnapKit

class TwitterProfileInfoView: UIView {
    private let usernameLabel: UILabel = {
        let v = UILabel()
        v.text = "iawaknahc"
        v.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return v
    }()
    private let realNameLabel: UILabel = {
        let v = UILabel()
        v.text = "Chan Ka Wai"
        v.font = UIFont.systemFont(ofSize: 25, weight: .regular)
        return v
    }()
    private let followerTitleLabel: UILabel = {
        let v = UILabel()
        v.text = "Followers"
        v.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return v
    }()
    private let followerCountLabel: UILabel = {
        let v = UILabel()
        v.text = "0"
        v.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return v
    }()
    private lazy var editProfileButton: UILabel = {
        let v = UILabel()
        v.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTapEditProfile))
        v.addGestureRecognizer(tap)
        v.text = "Edit Profile"
        v.textColor = UIColor.blue
        return v
    }()
    init() {
        super.init(frame: .zero)
        self.backgroundColor = UIColor(white: 0.8, alpha: 1)
        self.addSubview(self.usernameLabel)
        self.addSubview(self.realNameLabel)
        self.addSubview(self.followerTitleLabel)
        self.addSubview(self.followerCountLabel)
        self.addSubview(self.editProfileButton)

        self.usernameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
        }
        self.editProfileButton.snp.makeConstraints { make in
            make.top.equalTo(self.usernameLabel)
            make.left.equalTo(self.usernameLabel.snp.right).offset(6)
            make.right.equalToSuperview().offset(-16)
        }
        self.realNameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.usernameLabel.snp.bottom).offset(6)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        self.followerTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.realNameLabel.snp.bottom).offset(6)
            make.left.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
        }
        self.followerCountLabel.snp.makeConstraints { make in
            make.top.equalTo(self.followerTitleLabel)
            make.left.equalTo(self.followerTitleLabel.snp.right).offset(5)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc private func onTapEditProfile() {
        print("Edit profile")
    }
}
