//
//  ViewController.swift
//  AVAudio
//
//  Created by Joshua Homann on 6/17/17.
//  Copyright © 2017 josh. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    private var liftOffSound: AVPlayer! = AVPlayer(url: URL(string: "https://www.nasa.gov/mp3/640392main_STS-26_Liftoff.mp3")!)
    private var computerSound: AVPlayer! = AVPlayer(url: URL(string: "https://www.nasa.gov/mp3/640149main_Computers%20are%20in%20Control.mp3")!)
    override func viewDidLoad() {
        super.viewDidLoad()
        liftOffSound.play()
        liftOffSound.loop()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.computerSound.play()
        }
    }
}

extension AVPlayer {
    convenience init?(url: URL) {
        let playerItem = AVPlayerItem(url: url)
        self.init(playerItem: playerItem)
    }
    convenience init?(name: String, extension ext: String) {
        guard let url = Bundle.main.url(forResource: name, withExtension: ext) else {
            return nil
        }
        self.init(url: url)
    }
    func loop() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil, queue: nil) { notification in
            self.seek(to: kCMTimeZero)
            self.play()
        }
    }
    func endLoop() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
    }
}





