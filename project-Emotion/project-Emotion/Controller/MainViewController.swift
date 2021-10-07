//
//  MainViewController.swift
//  project-Emotion
//
//  Created by Jaeyoung Lee on 2021/09/29.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var addRecordButton: UIButton!
    @IBOutlet weak var gotoSettingButton: UIButton!
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setThemeInMainView()
        setAddRecordButton()
    }
    override func viewWillAppear(_ animated: Bool) {
        setThemeInMainView()
    }
    
    func setAddRecordButton() {
        let mainViewWidth = self.view.frame.width
        let mainViewHeight = self.view.frame.height
        let buttonSize = mainViewWidth * 0.2
        
        addRecordButton.frame.size = CGSize(width: buttonSize, height: buttonSize)
        addRecordButton.center = CGPoint(x: mainViewWidth / 2, y: mainViewHeight - (mainViewWidth / 4))
    }
    // MARK: - Set Theme
    func setThemeInMainView() {
        let themeColor = userDefaults.integer(forKey: userDefaultColor)
        
        switch themeColor {
        case defaultColor:
            Theme.shared.colors = ThemeColors(theme: defaultColor)
        case customColor:
            Theme.shared.colors = ThemeColors(theme: customColor)
        case seoulColor:
            Theme.shared.colors = ThemeColors(theme: seoulColor)
        default:
            print("error")
        }
        view.backgroundColor = Theme.shared.colors.mainViewBackground
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // if 메인에서 게이지뷰로 전달할 데이터가 있으면 전달.
        //guard let gaugeViewController = segue.destination as? GaugeViewController else { return }
    }
    
    @IBAction func pressedAddRecordButton(_ sender: UIButton) {
        performSegue(withIdentifier: "mainToGauge", sender: nil)
    }
    
    @IBAction func pressedGotoSettingButton(_ sender: UIButton) {
        performSegue(withIdentifier: "mainToSetting", sender: nil)
    }
    
}
