//
//  VideoCell.swift
//  YouTubeTutorial
//
//  Created by Admin on 7/1/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class VideoCell: BaseCell {
    var titleLabelHeightConstraint: NSLayoutConstraint?
    var video: Video? {
        didSet {
            titleLabel.text = video?.title

            setupThumbnailImage()

            setupProfileImage()

            if let channelName = video?.channel?.name, let numberOfViews = video?.views {

                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal

                let subtitleText = "\(channelName) • \(numberFormatter.string(from: numberOfViews)!) • 2 years ago "
                subtitleTextView.text = subtitleText
            }

            //measure title text
            if let title = video?.title {
                let size = CGSize(width: frame.width - 16 - 44 - 8 - 16, height: 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], context: nil)

                if estimatedRect.size.height > 20 {
                    titleLabelHeightConstraint?.constant = 44
                } else {
                    titleLabelHeightConstraint?.constant = 20
                }
            }
        }
    }
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.blue
        imageView.image = UIImage(named: "taylor_swift_blank_space")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    func setupProfileImage() {
        if let profileImageUrl = video?.channel?.profileImageName {
            userProfileImageView.loadImageUsingUrlString(urlString: profileImageUrl)
        }
    }

    func setupThumbnailImage() {
        if let thumbnailImageUrl = video?.thumbnailImageName {
            thumbnailImageView.loadImageUsingUrlString(urlString: thumbnailImageUrl)
        }
    }

    let userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .green
        imageView.image = UIImage(named: "taylor_swift_profile")
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        return imageView
    }()

    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230 / 255, green: 230 / 255, blue: 230 / 255, alpha: 1)
        return view
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Taylor swift - Blank Text"
        return label
    }()

    let subtitleTextView: UITextView = {
        let textView = UITextView()
        textView.text = "TaylorSwiftVEVO - 165,121,121,112 views - 2 years ago and ago"
        textView.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()


    override func setUpViews() {
        super.setUpViews()
        addSubview(thumbnailImageView)
        addSubview(separatorView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subtitleTextView)

        addConstraintsWithFormat("H:|-16-[v0]-16-|", views: thumbnailImageView)

        addConstraintsWithFormat("H:|-16-[v0(44)]", views: userProfileImageView)

        //vertical constraints
        addConstraintsWithFormat("V:|-16-[v0]-8-[v1(44)]-16-[v2(1)]|", views: thumbnailImageView, userProfileImageView, separatorView)

        addConstraintsWithFormat("H:|[v0]|", views: separatorView)

        //top constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        //left constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        //right constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        //height constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))

        //top constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
        //left constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        //right constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        //height constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
    }
}
