//
//  AvatarView.swift
//  GymCare
//
//  Created by Truong Nguyen Huu on 05/01/2023.
//

import UIKit

class AvatarView: UIView {

    @IBOutlet private weak var contentView: UIView!
    @IBOutlet weak var avatarView: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        avatarView.cornerRadius = self.frame.height / 2
    }

    func setupAvatarView(avatar: String?, gender: Int?) {
        avatarView.loadImage(urlString: avatar, access: "user")
        avatarView.borderColor = castToInt(gender) == 1 ? .color_FFACCB : .color_46C0FF
    }
    
    private func setupView() {
        Bundle.main.loadNibNamed("AvatarView", owner: self, options: nil)
        self.addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

}
