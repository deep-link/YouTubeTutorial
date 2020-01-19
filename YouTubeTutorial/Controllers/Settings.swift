//
// Created by Admin on 14/1/20.
// Copyright (c) 2020 Admin. All rights reserved.
//

import UIKit

class Setting: NSObject {
    let name: String
    let imageName: String

    init(name: String, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}

class Settings: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    let blackView = UIView()

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        return cv
    }()

    let cellHeight: CGFloat = 50

    let settings: [Setting] = {
        return [Setting(name: "Settings", imageName: "settings"), Setting(name: "Terms & privacy policy", imageName: "privacy"), Setting(name: "Send Feedback", imageName: "feedback"), Setting(name: "Help", imageName: "help"), Setting(name: "Switch Account", imageName: "switch_account"), Setting(name: "Cancel", imageName: "cancel")]
    }()

    private let cellID: String = "cellID"

    var homeController: HomeController?

    override init() {
        super.init()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SettingItem.self, forCellWithReuseIdentifier: cellID)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SettingItem

        let setting = settings[indexPath.item]
        cell.setting = setting

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let setting = settings[indexPath.item]
        handleDismissMore(setting: setting)

    }

    func handleMore() {
        if let window = UIApplication.shared.keyWindow {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)

            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismissMore)))

            window.addSubview(blackView)

            window.addSubview(collectionView)

            let height: CGFloat = CGFloat(settings.count) * cellHeight
            let y = window.frame.height - height
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            collectionView.isScrollEnabled = false
            blackView.frame = window.frame
            blackView.alpha = 0

            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {

                self.blackView.alpha = 1

                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)

            }, completion: nil)
        }

    }

    @objc func handleDismissMore(setting: Setting) {

        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0

            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
        }) { (completed: Bool) in
            if type(of: setting) == Setting.self  && setting.name != "" && setting.name != "Cancel" {
                self.homeController?.showControllerForSettings(setting: setting)
            }

        }
    }
}