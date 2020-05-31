//
//  DetailViewController.swift
//  Payme
//
//  Created by Muraino Yakubu on 5/30/20.
//  Copyright © 2020 Muraino Yakubu. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

 
    

    @IBOutlet weak var pageView: UIPageControl!
    
    var imgArr = [  UIImage(named:"Alexandra Daddario"),
                    UIImage(named:"Angelina Jolie") ,
                    UIImage(named:"Anne Hathaway") ,
                    UIImage(named:"Dakota Johnson") ,
                    UIImage(named:"Emma Stone") ,
                    UIImage(named:"Emma Watson") ,
                    UIImage(named:"Halle Berry") ,
                    UIImage(named:"Jennifer Lawrence") ,
                    UIImage(named:"Jessica Alba") ,
                    UIImage(named:"Scarlett Johansson") ]
    
    var timer = Timer()
    var counter = 0
    
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    override func viewDidLoad() {
            super.viewDidLoad()
            pageView.numberOfPages = imgArr.count
            pageView.currentPage = 0
            DispatchQueue.main.async {
                self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
            }
        }

        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
       @objc func changeImage() {
        
        if counter < imgArr.count {
            let index = IndexPath.init(item: counter, section: 0)
            self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageView.currentPage = counter
            counter += 1
        } else {
            counter = 0
            let index = IndexPath.init(item: counter, section: 0)
            self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            pageView.currentPage = counter
            counter = 1
        }
            
        }

    }

    extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return imgArr.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellui", for: indexPath) as! ScrollCollectionViewCell
           
            cell.srollImage.image = imgArr[indexPath.row]
        
            return cell
        }
    }






extension DetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = sliderCollectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
