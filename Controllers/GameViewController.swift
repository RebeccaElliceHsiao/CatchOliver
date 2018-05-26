//
//  GameViewController.swift
//  CatchOliver
//
//  Created by Rebecca Hsiao on 2018/05/25.
//  Copyright © 2018年 Rebecca Hsiao. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var catchLabel: UILabel!
    @IBOutlet var timerLabel: UILabel!
    
    var seconds = 10
    var timer = Timer()
    var isTimerRunning = true
    
    var myScore = 0
    
    //time
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer),  userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer(){
        if seconds != 0 {
            seconds -= 1
            timerLabel.text = "\(seconds)"

        } else {
            endTimer()
            let vc = ViewController()
            vc.myResult = "Your result is \(myScore), try again!"
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    func endTimer() {
        timer.invalidate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //scoreLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        runTimer()


        let nib = UINib(nibName: "GridCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "GridCell")
        self.collectionView.dataSource = self
        
        if let myLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            myLayout.scrollDirection = .horizontal
            myLayout.itemSize = CGSize(width: 75, height: 80)
            
        self.collectionView.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        self.collectionView.delegate = self
            
        print("random cell number is :\(cellIndex)")
        self.collectionView.isScrollEnabled = false
            
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // "random" numbers
    var cellIndex =  Int(arc4random_uniform(15))
    var doggieType = 0

    // collectionView dataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "GridCell", for: indexPath) as! GridCell
        
        if indexPath.row == cellIndex {
            if doggieType == 0 {
                cell.myHeroDog.image = #imageLiteral(resourceName: "oliver")
            }
            if doggieType == 1 {
                cell.myHeroDog.image = #imageLiteral(resourceName: "pinky")
            }
            if doggieType == 2 {
                cell.myHeroDog.image = #imageLiteral(resourceName: "pixel")
            }
        } else {
            cell.myHeroDog.image = nil
        }
        cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cell.layer.cornerRadius = 10
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if indexPath.row == cellIndex {
            
            if doggieType == 0 {
                myScore += 1
                
                UIView.animate(withDuration: 0.2, animations: {
                    self.catchLabel.transform = CGAffineTransform(translationX: 0, y: -80)
                    self.catchLabel.textColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
                    self.catchLabel.textAlignment = .left
                    self.catchLabel.text = "Catch Oliver, the best dog!"
                }) { (Void) in
                    self.catchLabel.textColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
                    self.catchLabel.transform = .identity
                    self.catchLabel.text = "Catch Oliver !"
                }
            }
            if doggieType == 1 {
                myScore += 2
            }
            if doggieType == 2 {
                myScore += 2
            }
            scoreLabel.textColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
            print("\(myScore)")
            UIView.animate(withDuration: 0.4, animations: {
                self.scoreLabel.transform = CGAffineTransform(translationX: 0, y: -120)
                self.scoreLabel.alpha = 0.3
            }) { (_) in
                self.scoreLabel.transform = .identity
                self.scoreLabel.alpha = 1
                self.scoreLabel.textColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            }
        } else {
            myScore -= 5
            UIView.animate(withDuration: 0.3, animations: {
                self.scoreLabel.transform = CGAffineTransform(translationX: 0, y: +80)
                self.scoreLabel.alpha = 0.1
            }) { (_) in
                self.scoreLabel.transform = .identity
                self.scoreLabel.alpha = 1
                self.scoreLabel.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            }
            scoreLabel.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        }
        cellIndex = Int(arc4random_uniform(15))
        doggieType = Int(arc4random_uniform(3))
        scoreLabel.text = String(myScore)

        scoreLabel.sizeToFit()
        collectionView.reloadData()
        print("random doggie is :\(doggieType)")
    }
    
//    override func viewDidLayoutSubviews() {
//
//        collectionView.reloadData()
//    }
    
    }
