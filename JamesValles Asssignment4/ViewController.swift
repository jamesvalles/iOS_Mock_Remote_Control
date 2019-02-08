//
//  ViewController.swift
//  JamesValles Asssignment 4 - Mock Television Remote
//
//  Created by James Valles on 2/3/19.
//  Copyright © 2019 DPU James Valles. All rights reserved.
//

//Bonus points: Attempted to use auto layout to resize views on different screens. Added Launch screen image. Also logo changes when favorite channels pressed. Implemented custom UI display where label texts disappear and appear when power switch is turned on. Favorite channel resets when any other channel buttons are pressed.

import UIKit

class ViewController: UIViewController {
    var current_channel: Int = 0
    var speaker_volume: String = "30"
    var first_Digit: String = ""
    var isTvOn: Bool = false
    var typing: Bool = true
    
    //IBOutlets
    @IBOutlet weak var Logo: UIImageView!
    @IBOutlet weak var power_label: UILabel!
    @IBOutlet weak var channel_label: UILabel!
    @IBOutlet weak var volume_label: UILabel!
    @IBOutlet weak var now_playing: UILabel!
    @IBOutlet weak var channel_status: UILabel!
    @IBOutlet weak var volume_slider: UISlider!
    @IBOutlet weak var favorite_channel: UISegmentedControl!
    
    
    //IB Action that called functions to either turn TV on/off
    @IBAction func Power(_ sender: UISwitch) {
        if sender.isOn {
            turnTVon()
        } else {
            turnTVoff()
        }
    }
    
    
    //Function to Turn TV on
    func turnTVon() {
        isTvOn = true
        power_label.text = "ON"
        
        if first_Digit == "" {
            channel_label.text = "1"
        } else {
            channel_label.text = first_Digit
        }
        now_playing.text = "NOW PLAYING"
        volume_label.text = volume_label.text
        power_label.textColor = .green
        channel_status.text = "Current Channel:"
        
    }
    
    //Function to Turn TV off
    func turnTVoff() {
        first_Digit = channel_label.text!
        isTvOn = false
        power_label.text = "OFF"
        channel_label.text = ""
        now_playing.text = "TV OFF"
        volume_label.text = "0"
        power_label.textColor = .red
        channel_status.text = ""
        Logo.image = UIImage(named: "dishtv.png")
        volume_slider.setValue(0, animated: true)
        favorite_channel.selectedSegmentIndex = -1
    }
    
    //IB Action func updates volume label based on UISlider value
    @IBAction func Volume(_ sender: UISlider) {
        
        if isTvOn == true {
            volume_label.text = String(Int(sender.value))
        } else {
            volume_label.text = "0"
            sender.setValue(0, animated: true)
        }
    }
    
    //IBAction func updates channel label with digits pressed, no more than two
    @IBAction func Channel_digits(_ sender: UIButton) {
        // var typing : Bool = true
        
        if isTvOn == true {
            favorite_channel.selectedSegmentIndex = -1
            
            if let buttonText = sender.currentTitle {
                if typing {
                    typing = false
                    channel_label.text = sender.currentTitle!
                } else {
                    typing = true
                    let hasecond_Digit = channel_label.text!
                    if hasecond_Digit == "0" {
                        channel_label.text = buttonText
                    } else {
                        channel_label.text = hasecond_Digit + buttonText
                    }
                    
                }
            }
        }
    }
    
    
    //IBAction func controls Favorite Channels using UISegmentedControl, and changes logo
    @IBAction func Favorite_channels(_ sender: UISegmentedControl) {
        let value: Int = sender.selectedSegmentIndex
        
        if isTvOn == true {
            
            switch value {
            case 0:
                channel_label.text = "7"
                Logo.image = UIImage(named: "abclogo.png")
            case 1:
                channel_label.text = "5"
                Logo.image = UIImage(named: "nbclogo.png")
            case 2:
                channel_label.text = "2"
                Logo.image = UIImage(named: "cbslogo.png")
            case 3:
                channel_label.text = "32"
                Logo.image = UIImage(named: "foxlogo.png")
            default:
                Logo.image = UIImage(named: "dishtv.png")
                channel_label.text = channel_label.text
            }
        } else {
            favorite_channel.selectedSegmentIndex = -1
        }
    }
    
    
    //IBAction func changes channel_label based on selection (1-99 inclusive)
    @IBAction func ChannelUpDown(_ sender: UIButton) {
        favorite_channel.selectedSegmentIndex = -1
        Logo.image = UIImage(named: "dishtv.png")
        let value: Int = sender.tag
        if isTvOn == true {
            switch value {
            case 2:
                if current_channel < 100 {
                    current_channel = Int(channel_label.text!)! + 1
                    channel_label.text = String(current_channel)
                }
            case 3:
                current_channel = Int(channel_label.text!)!
                if current_channel > 1 {
                    current_channel -= 1
                    channel_label.text = String(current_channel)
                }
            default:
                break;
            }
            
        }
    }
    
    //Changes Status Bar color to white
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
}



