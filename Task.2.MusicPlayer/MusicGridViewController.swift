//
//  MusicGridViewController.swift
//  Task.2.MusicPlayer
//
//  Created by Natalia Kapusta on 21/04/2017.
//  Copyright © 2017 Natalia Kapusta. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

private var songSet:[Song] = [Song(title: "Ironic", artist: "Alanis Morisette", image: "song_image_0.jpg", song: "song_0.mp3"),
                               Song(title: "The Scientist", artist: "Coldplay", image: "song_image_1.jpg", song: "song_1.mp3"),
                               Song(title: "Grenade", artist: "Bruno Mars", image: "song_image_2.jpg", song: "song_2.mp3"),
                               Song(title: "1973", artist: "James Blunt", image: "song_image_3.jpg", song: "song_3.mp3"),
                               Song(title: "Kiss Me", artist: "Sixpence None the Richer", image: "song_image_4.jpg", song: "song_4.mp3"),
                               Song(title: "Sleeping Satellite", artist: "Tasmin Archer", image: "song_image_5.jpg", song: "song_5.mp3"),
                               Song(title: "Walk", artist: "Kwabs", image: "song_image_6.jpg", song: "song_6.mp3"),
                               Song(title: "Pumpin Blood", artist: "NONONO", image: "song_image_7.jpg", song: "song_7.mp3"),
                               Song(title: "Be the One", artist: "Dua Lipa", image: "song_image_8.jpg", song: "song_8.mp3"),
                               Song(title: "Monday", artist: "Matt Corby", image: "song_image_9.jpg", song: "song_9.mp3"),
                               Song(title: "Wasn't Expecting That", artist: "Jamie Lawson", image: "song_image_10.jpg", song: "song_10.mp3"),
                               Song(title: "Sugar", artist: "Francesco Yates", image: "song_image_11.jpg", song: "song_11.mp3"),]


class MusicGridViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    @IBAction func returnToGrid(segue :UIStoryboardSegue) {
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        
        //HIDE NAVIGATION BAR
        self.navigationController?.isNavigationBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return songSet.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! Cell
    
        // Configure the cell
        let song = songSet[indexPath.row]
        cell.musicImageView?.image = UIImage(named: song.image)
    
        return cell
    }
    
    //ADJUST CELL SIZE (4X2)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        var collectionViewSize = collectionView.frame.size
        collectionViewSize.width = collectionViewSize.width/2.0 //row
        let topBarSize = UIApplication.shared.statusBarFrame.height
        collectionViewSize.height = (collectionViewSize.height-topBarSize)/4.0 //column
        return collectionViewSize
    }
    
    //SEGUE TO MUSICPLAYER
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier=="playMusic"{
            
            if let indexPaths=collectionView?.indexPathsForSelectedItems{
                let destinationController = segue.destination as! SwipeController
                //destinationController.transitioningDelegate = slideDownTransition
                destinationController.index = indexPaths[0].row
                destinationController.songSet = songSet
                collectionView?.deselectItem(at: indexPaths[0], animated: false)
            }
        }
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let point = scrollView.contentOffset.y
        print(point)
        
        if(point<69){
            print("1")
            scrollView.setContentOffset(CGPoint(x:0,y:0), animated: true)
        }
        else if(point>69 && point<206){
            print("2")
            scrollView.setContentOffset(CGPoint(x:0,y:137), animated: true)
        }
        else if(point>206 && point<343){
            print("3")
            scrollView.setContentOffset(CGPoint(x:0,y:254), animated: true)
        }
    }
    
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
