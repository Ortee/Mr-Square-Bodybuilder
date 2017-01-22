//
//  AchievementsViewController.swift
//  Bodybuilder
//
//  Created by Mateusz Oracz on 22.01.2017.
//  Copyright © 2017 BatoregoTeam. All rights reserved.
//

import UIKit

class AchievementsViewController: UIViewController {

    @IBOutlet weak var QuestionMark_Level_1: UILabel!
    @IBOutlet weak var QuestionMark_Level_10: UILabel!
    @IBOutlet weak var QuestionMark_Level_20: UILabel!
    @IBOutlet weak var QuestionMark_Level_40: UILabel!
    @IBOutlet weak var QuestionMark_Earn_1: UILabel!
    @IBOutlet weak var QuestionMark_Earn_10: UILabel!
    @IBOutlet weak var QuestionMark_Earn_100: UILabel!
    @IBOutlet weak var QuestionMark_Earn_50: UILabel!
    @IBOutlet weak var QuestionMark_Earn_1000: UILabel!
    @IBOutlet weak var QuestionMark_Level_100: UILabel!
    @IBOutlet weak var QuestionMark_Level_200: UILabel!
    @IBOutlet weak var QuestionMark_Energy_0: UILabel!
    @IBOutlet weak var QuestionMark_Top_1: UILabel!
    @IBOutlet weak var QuestionMark_Strength_1000: UILabel!
    @IBOutlet weak var QuestionMark_Strength_100: UILabel!
    @IBOutlet weak var QuestionMark_Strenght_500: UILabel!
    @IBOutlet weak var Label_Level_40: UILabel!
    @IBOutlet weak var Label_Level_20: UILabel!
    @IBOutlet weak var Label_Level_10: UILabel!
    @IBOutlet weak var Label_Level_1: UILabel!
    @IBOutlet weak var Label_Earn_1: UILabel!
    @IBOutlet weak var Label_Earn_10: UILabel!
    @IBOutlet weak var Label_Earn_50: UILabel!
    @IBOutlet weak var Label_Earn_100: UILabel!
    @IBOutlet weak var Label_Earn_1000: UILabel!
    @IBOutlet weak var Label_Level_100: UILabel!
    @IBOutlet weak var Label_Level_200: UILabel!
    @IBOutlet weak var Label_Top_1: UILabel!
    @IBOutlet weak var Label_Energy_0: UILabel!
    @IBOutlet weak var Label_Strength_1000: UILabel!
    @IBOutlet weak var Label_Strength_500: UILabel!
    @IBOutlet weak var Label_Strength_100: UILabel!
    @IBOutlet weak var Image_Earn_1: UIImageView!
    @IBOutlet weak var Image_Earn_10: UIImageView!
    @IBOutlet weak var Image_Earn_50: UIImageView!
    @IBOutlet weak var Image_Earn_100: UIImageView!
    @IBOutlet weak var Image_Earn_1000: UIImageView!
    @IBOutlet weak var Image_Level_1: UIImageView!
    @IBOutlet weak var Image_Level_10: UIImageView!
    @IBOutlet weak var Image_Level_20: UIImageView!
    @IBOutlet weak var Image_Level_40: UIImageView!
    @IBOutlet weak var Image_Level_100: UIImageView!
    @IBOutlet weak var Image_Level_200: UIImageView!
    @IBOutlet weak var Image_Energy_0: UIImageView!
    @IBOutlet weak var Image_Top_1: UIImageView!
    @IBOutlet weak var Image_Strength_1000: UIImageView!
    @IBOutlet weak var Image_Strength_500: UIImageView!
    @IBOutlet weak var Image_Strength_100: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        unlock(unlock: true, QuestionMark: QuestionMark_Level_1, Label: Label_Level_1, Image: Image_Level_1)
        if(bodybuilder.getLeveL() > 10) {
            unlock(unlock: true, QuestionMark: QuestionMark_Level_10, Label: Label_Level_10, Image: Image_Level_10)
        }
        if(bodybuilder.getLeveL() > 20) {
            unlock(unlock: true, QuestionMark: QuestionMark_Level_20, Label: Label_Level_20, Image: Image_Level_20)
        }
        if(bodybuilder.getLeveL() > 40) {
            unlock(unlock: true, QuestionMark: QuestionMark_Level_40, Label: Label_Level_40, Image: Image_Level_40)
        }
        if(bodybuilder.getLeveL() > 100) {
           unlock(unlock: true, QuestionMark: QuestionMark_Level_100, Label: Label_Level_100, Image: Image_Level_100)
        }
        if(bodybuilder.getLeveL() > 200) {
           unlock(unlock: true, QuestionMark: QuestionMark_Level_200, Label: Label_Level_200, Image: Image_Level_200)
        }
        if(bodybuilder.getExperienceIncreaseValue() > 100) {
            unlock(unlock: true, QuestionMark: QuestionMark_Strength_100, Label: Label_Strength_100, Image: Image_Strength_100)
        }
        if(bodybuilder.getExperienceIncreaseValue() > 500) {
            unlock(unlock: true, QuestionMark: QuestionMark_Strenght_500, Label: Label_Strength_500, Image: Image_Strength_500)
        }
        if(bodybuilder.getExperienceIncreaseValue() > 1000) {
            unlock(unlock: true, QuestionMark: QuestionMark_Strength_1000, Label: Label_Strength_1000, Image: Image_Strength_1000)
        }
        if(bodybuilder.getCash() > 1.00) {
            unlock(unlock: true, QuestionMark: QuestionMark_Earn_1, Label: Label_Earn_1, Image: Image_Earn_1)
        }
        if(bodybuilder.getCash() > 10.00) {
            unlock(unlock: true, QuestionMark: QuestionMark_Earn_10, Label: Label_Earn_10, Image: Image_Earn_10)
        }
        if(bodybuilder.getCash() > 50.00) {
            unlock(unlock: true, QuestionMark: QuestionMark_Earn_50, Label: Label_Earn_50, Image: Image_Earn_50)
        }
        if(bodybuilder.getCash() > 100.00) {
            unlock(unlock: true, QuestionMark: QuestionMark_Earn_100, Label: Label_Earn_100, Image: Image_Earn_100)
        }
        if(bodybuilder.getCash() > 1000.00) {
            unlock(unlock: true, QuestionMark: QuestionMark_Earn_1000, Label: Label_Earn_1000, Image: Image_Earn_1000)
        }
        if(bodybuilder.getEnergy() == 0) {
          unlock(unlock: true, QuestionMark: QuestionMark_Energy_0, Label: Label_Energy_0, Image: Image_Energy_0)
        }
//        unlock(unlock: true, QuestionMark: QuestionMark_Top_1, Label: Label_Top_1, Image: Image_Top_1)
    }
    
    func unlock(unlock: Bool, QuestionMark: UILabel, Label: UILabel, Image: UIImageView) {
            QuestionMark.isHidden = unlock
            Label.isHidden = !unlock
            Image.isHidden = !unlock
    }

}
