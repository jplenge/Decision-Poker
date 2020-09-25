//
//  InfoViewController.swift
//  DecisionPoker
//
//  Created by Jürgen Plenge on 26.07.19.
//  Copyright © 2019 Jodi Szarko. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    
    
    @IBOutlet weak var localizedTextView: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.localizedTextView.text = NSLocalizedString("This page shows the first \"hand\" that the program \"deals\" for you (i.e. it shows your initial decision result). If you are happy with your result, click the \"Hold em'!\" button at the bottom of the screen. If you would like to change one of your results to a fixed choice, hit the \"cheat\" button below the desired result. A picker view will pop up. Choose the \"card\" you would like to substitute in and hit \"cheat\" again. This will change your final outcome. If you would like to randomly reselect a \"card\", hit \"Redraw\". This will randomly reselect and change the outcome for that result. When the result is re-optimized to your liking, hit the \"Hold em'!\" button to go to the next screen. If you do not want to save or share your result, you can also stop here if you want.", comment: "info pane text")
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
