//
//  ViewController.swift
//  SimpleAudioRecorder
//
//  Created by Ilgar Ilyasov on 11/6/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func play(_ sender: Any) {
        
        defer { updateButton() }
        
        guard let audioURL = Bundle.main.url(forResource: "empire-of-the-sun-walking-on-a-dream", withExtension: "mp3") else { return }
        
        guard !isPlaying else {
            player?.pause()
            return
        }
        
        if player != nil && !isPlaying {
            player?.play()
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: audioURL)
            player?.play()
        } catch {
            NSLog("Unable to play audio: \(error.localizedDescription)")
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        self.player = nil
        updateButton()
    }
    
    func updateButton() {
        let playButtonTitle = isPlaying ? "Stop" : "Play"
        playButton.setTitle(playButtonTitle, for: .normal)
    }
    
    private var player: AVAudioPlayer?
    private var isPlaying: Bool {
        return player?.isPlaying ?? false
    }
    @IBOutlet weak var playButton: UIButton!
}

