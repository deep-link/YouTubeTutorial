//
//  ViewController.swift
//  YouTubeTutorial
//
//  Created by Admin on 5/1/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import Foundation

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let menuBar: MenuBar = {
        return MenuBar()
    }()
    let videos: [Video] = {
        let kanyeChannel = Channel()
        kanyeChannel.name = "Kanye channel name"
        kanyeChannel.profileImageName = "kanye_profile"
        
        var blankSpace = Video()
        blankSpace.title = "Taylor Swift - Blank Space"
        blankSpace.thumbnailImageName = "taylor_swift_blank_space"
        blankSpace.channel = kanyeChannel
        blankSpace.views = 12345678
        var badBlood = Video()
        badBlood.title = "Taylor Swift - Bad Blood"
        badBlood.thumbnailImageName = "taylor_swift_bad_blood"
        badBlood.channel = kanyeChannel
        badBlood.views = 1234567890
    
        
        return [
            blankSpace,
            badBlood
        ]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Home"
        navigationController?.navigationBar.isTranslucent = false
        let titleLable = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        navigationItem.titleView = titleLable
        titleLable.textColor = UIColor.white
        titleLable.font = UIFont.systemFont(ofSize: 20)
        titleLable.text = "Home"
        collectionView.backgroundColor = UIColor.white
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        setUpMenuBar()
        setUpNavBarButtons()
    }

    func setUpNavBarButtons() {
        let searchImage = UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))

        let moreButton = UIBarButtonItem(image: UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))

        navigationItem.rightBarButtonItems = [moreButton, searchBarButtonItem]
    }

    @objc func handleMore() {

    }

    @objc func handleSearch() {
        print(123)
    }

    private func setUpMenuBar() {
        view.addSubview(menuBar)
        view.addConstraintsWithFormat("H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat("V:|[v0(50)]|", views: menuBar)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell
        cell.video = videos[indexPath.item]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 16 - 16) * 9 / 16
        return CGSize(width: view.frame.width, height: height + 16 + 68)
    }
}



