//
//  SplashViewController.swift
//  CarMinder
//
//  Created by Rajat Rajat on 4/14/24.
// This controller is used to show the splash screen of the application.
//


import UIKit
import AVFoundation

class SplashViewController: UIViewController {
    

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backgroundView: UIView!
    
    var audioPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Load the sound file
        if let soundURL = Bundle.main.url(forResource: "opening", withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.prepareToPlay()
            } catch {
                print("Error loading sound file: \(error.localizedDescription)")
            }
        }
        
        // Animate the title and play the sound
        animateTitle()
        
        // Wait 2 seconds and go to the next screen
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2){
            self.performSegue(withIdentifier: "firstScreen", sender: nil)
        }
    }
    
    private func animateTitle() {
        // Set the initial state of the label
        titleLabel.alpha = 0
        titleLabel.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)

        // Animate the label to fade in and scale up
        UIView.animate(withDuration: 1.0, delay: 0.5, options: .curveEaseOut, animations: {
            self.titleLabel.alpha = 1
            self.titleLabel.transform = .identity
        }) { (_) in
            // After the title animation completes, transition the background to red and fade out
            UIView.animate(withDuration: 1.0, animations: {
                self.backgroundView.backgroundColor = .red
                self.addRippleEffect() // Add ripple effect animation
            }) { (_) in
                // Fade out the view controller
                UIView.animate(withDuration: 0.5, animations: {
                    self.view.alpha = 0
                })
            }
        }
        
        // Play the sound
        audioPlayer?.play()
    }
    
    private func addRippleEffect() {
        let rippleLayer = CALayer()
        rippleLayer.bounds = backgroundView.bounds.insetBy(dx: -10, dy: -10)
        rippleLayer.position = backgroundView.center
        rippleLayer.backgroundColor = UIColor.clear.cgColor
        rippleLayer.borderWidth = 10
        rippleLayer.borderColor = UIColor.white.cgColor
        rippleLayer.cornerRadius = backgroundView.bounds.width / 2
        
        backgroundView.layer.addSublayer(rippleLayer)
        
        let rippleAnimation = CABasicAnimation(keyPath: "transform.scale")
        rippleAnimation.fromValue = 0
        rippleAnimation.toValue = 1.5
        rippleAnimation.duration = 1.0
        rippleAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        rippleAnimation.isRemovedOnCompletion = true
        
        rippleLayer.add(rippleAnimation, forKey: "rippleEffect")
    }
    
}
