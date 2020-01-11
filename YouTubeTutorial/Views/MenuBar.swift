//
//  MenuBar.swift
//  YouTubeTutorial
//
//  Created by Admin on 7/1/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class MenuBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        cv.dataSource = self
        cv.delegate = self
        return cv

    }()

    let cellId = "cellId"

    let imageNames = [
        "home",
        "trending",
        "subscriptions",
        "trending",
        "account"
    ]

    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView.allowsSelection = true
        self.collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .bottom)
        let indexPath = IndexPath(item: 0, section: 0)
        DispatchQueue.main.async {
            self.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .left)
        }
        addSubview(collectionView)
        addConstraintsWithFormat("H:|[v0]|", views: collectionView)
        addConstraintsWithFormat("V:|[v0]|", views: collectionView)
        backgroundColor = UIColor(red: 230 / 255, green: 32 / 255, blue: 31 / 255, alpha: 1)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! MenuCell
        cell.imageView.image = UIImage(named: imageNames[indexPath.item])?.withRenderingMode(.alwaysTemplate)
        cell.imageView.tintColor = UIColor.rgb(red: 91, green: 14, blue: 13)
//        cell.backgroundColor = UIColor.blue
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 4, height: frame.height)
    }
}
