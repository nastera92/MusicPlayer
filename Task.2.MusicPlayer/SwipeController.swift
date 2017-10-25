//
//  SwipeController.swift
//  Task.2.MusicPlayer
//
//  Created by Natalia Kapusta on 21/04/2017.
//  Copyright © 2017 Natalia Kapusta. All rights reserved.
//

import UIKit
import AVFoundation

class SwipeController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource, AVAudioPlayerDelegate {
    
    var index = 0
    var songSet:[Song] = []
    var songName:String!
    var path:String!
    var audioFileURL:URL!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var currentIndex = 0
    var nextIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        dataSource = self
        delegate = self
        self.automaticallyAdjustsScrollViewInsets=false
        
        //INITIATE DETAIL VIEW - MUSIC PLAYER
        if let startingViewController = musicPlayerView(at:index){
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
        }
        
        //DEFAULT AUDIO FILE
        songName = songSet[index].song
        path = Bundle.main.path(forResource: songName, ofType:nil)!
        audioFileURL = URL(fileURLWithPath: path)
        
        //START AUDIO
        do {
            appDelegate.audioPlayer = try AVAudioPlayer(contentsOf: audioFileURL)
            appDelegate.audioPlayer.prepareToPlay()
            appDelegate.audioPlayer.play()
        }
        catch {
            print(error)
        }
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        currentIndex = (viewController as! MusicPlayer).index
        currentIndex -= 1
        
        return musicPlayerView(at: currentIndex)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        currentIndex = (viewController as! MusicPlayer).index
        currentIndex += 1
        
        return musicPlayerView(at: currentIndex)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers:[UIViewController], transitionCompleted completed: Bool) {
        
        if finished && completed{
            appDelegate.audioPlayer.stop()
            songName = songSet[nextIndex].song
            path = Bundle.main.path(forResource: songName, ofType:nil)!
            audioFileURL = URL(fileURLWithPath: path)
            
            do {
                appDelegate.audioPlayer = try AVAudioPlayer(contentsOf: audioFileURL)
                appDelegate.audioPlayer.prepareToPlay()
                appDelegate.audioPlayer.setVolume(0.1, fadeDuration: 0)
                appDelegate.audioPlayer.play()
            }
            catch {
                print(error)
                }
            }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        
        if let itemController = pendingViewControllers[0] as? MusicPlayer {
            
            nextIndex = itemController.index
            
            print("Page index = \(nextIndex)")
        }
    }
    
    func musicPlayerView(at index:Int) -> MusicPlayer?{
        if index<0||index>=12{
            return nil
        }
        
        if let musicPlayer = storyboard?.instantiateViewController(withIdentifier: "MusicPlayer") as? MusicPlayer{
            musicPlayer.imageName = songSet[index].image
            musicPlayer.titleName = songSet[index].title
            musicPlayer.artistName = songSet[index].artist
            musicPlayer.index=index
            return musicPlayer
        }
        return nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
