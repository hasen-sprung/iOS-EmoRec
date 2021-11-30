import UIKit

protocol CreateRecordViewDelegate {
    func getGaugeLevel() -> Int
    func dismissCreateRecordView()
    func completeCreateRecordView()
    func saveRecord(newDate: Date, newGagueLevel: Int, newMemo: String?)
}

class CreateRecordView: UIView {
    var delegate: CreateRecordViewDelegate?
    
    private let CRBackgroundView =  UIView()
    private let CRBtnBackgroundView = UIImageView()
    private let CRBtnIcon = UIImageView()
    private let cancelButton = UIButton()
    private let completeButton = UIButton()
    private let CRTextView = UITextView()
    private var date = Date()
    private var byteView = UILabel()
    
    func setCreateRecordView() {
        CRTextView.delegate = self
        let viewSize = self.frame.width * 0.8
        
        self.backgroundColor = .clear
        date = Date()
        CRBackgroundView.frame = CGRect(x: 0, y: 0, width: viewSize, height: viewSize * 1.22)
        self.addSubview(CRBackgroundView)
        setCRBackgroundViewShape()
        setCRBackgroundViewContraints()
        setCRBackgroundViewComponents()
        CRBtnBackgroundView.isUserInteractionEnabled = true
        cancelButton.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        completeButton.addTarget(self, action: #selector(completeButtonPressed), for: .touchUpInside)
    }
    
    func setCRTextView() {
        CRTextView.textContainer.maximumNumberOfLines = 15
        CRTextView.frame.size = CGSize(width: CRBackgroundView.frame.width * 0.8,
                                       height: CRBackgroundView.frame.height * 0.6)
        CRTextView.center = CGPoint(x: CRBackgroundView.frame.width / 2,
                                    y: CRBackgroundView.frame.height / 2)
        CRTextView.font = UIFont(name: "Pretendard-Regular", size: 16)
        CRTextView.backgroundColor = .clear
        CRTextView.textColor = .black
        CRTextView.becomeFirstResponder()
        CRTextView.isScrollEnabled = true
        CRBackgroundView.addSubview(CRTextView)
        byteView.text = "0/180"
        byteView.frame.size = CGSize(width: CRBackgroundView.frame.width * 0.8,
                                     height: byteView.intrinsicContentSize.height)
        byteView.frame.origin = CGPoint(x: CRBackgroundView.frame.width * 0.1,
                                        y: CRBackgroundView.frame.height * 0.8)
        byteView.textAlignment = .right
        byteView.textColor = .lightGray
        byteView.font = UIFont(name: "Cardo-Regular", size: 13)
        CRBackgroundView.addSubview(byteView)
    }
    
    @objc func cancelButtonPressed() {
        impactFeedbackGenerator?.impactOccurred()
        CRTextView.endEditing(true)
        completeButton.setTitleColor(UIColor(r: 163, g: 173, b: 178), for: .normal)
        cancelButton.setTitleColor(.black, for: .normal)
        cancelButton.isEnabled = false
        UIView.animate(withDuration: 0.5, delay: 0.0, animations: { [self] in
            CRBtnIcon.center.x = CRBackgroundView.frame.width * 0.22
        }) { (completed) in
            self.cancelButton.isEnabled = true
            if let d = self.delegate {
                d.dismissCreateRecordView()
            }
        }
    }
    
    @objc func completeButtonPressed() {
        feedbackGenerator?.notificationOccurred(.success)
        if let d = self.delegate {
            CRTextView.endEditing(true)
            d.completeCreateRecordView()
            d.saveRecord(newDate: date,
                         newGagueLevel: d.getGaugeLevel(),
                         newMemo: CRTextView.text)
            UserDefaults.shared.set(false, forKey: "guideAvail")
        }
    }
}

// MARK: - set textview setting

extension CreateRecordView: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let existingLines = textView.text.components(separatedBy: CharacterSet.newlines)
        let newLines = text.components(separatedBy: CharacterSet.newlines)
        let linesAfterChange = existingLines.count + newLines.count - 1
        if(text == "\n") {
            return linesAfterChange <= textView.textContainer.maximumNumberOfLines
        }
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        byteView.text = "\(numberOfChars)/180"
        return numberOfChars <= 180
    }
}

// MARK: - set components

extension CreateRecordView {
    private func setCRBackgroundViewComponents() {
        setSeperateLine()
        setDateLabel()
        setButtonBackground()
        setBtnIcon()
        setButtons()
    }
    
    private func setSeperateLine() {
        let seperateUpperView = UIView()
        let seperateUnderView = UIView()
        
        seperateUpperView.frame.size = CGSize(width: CRBackgroundView.frame.width,
                                              height: 1)
        seperateUnderView.frame.size = seperateUpperView.frame.size
        seperateUpperView.backgroundColor = .white
        seperateUnderView.backgroundColor = UIColor(r: 195, g: 201, b: 205)
        seperateUpperView.center = CGPoint(x: CRBackgroundView.frame.width / 2,
                                           y: CRBackgroundView.frame.height / 6)
        seperateUnderView.center = CGPoint(x: CRBackgroundView.frame.width / 2,
                                           y: CRBackgroundView.frame.height / 6 + 1)
        CRBackgroundView.addSubview(seperateUpperView)
        CRBackgroundView.addSubview(seperateUnderView)
    }
    
    private func setDateLabel() {
        let dateLabel = UILabel()
        
        dateLabel.text = getDateString()
        dateLabel.font = UIFont(name: "Cardo-Regular", size: 17)
        dateLabel.textColor = .black
        dateLabel.textAlignment = .center
        dateLabel.frame.size = CGSize(width: CRBackgroundView.frame.width,
                                      height: CRBackgroundView.frame.height / 8)
        dateLabel.center = CGPoint(x: CRBackgroundView.frame.width / 2,
                                   y: CRBackgroundView.frame.height / 11)
        CRBackgroundView.addSubview(dateLabel)
    }
    
    private func getDateString() -> String {
        let df = DateFormatter()
        var dateString: String?
        
        df.dateFormat = "yyyy. M. d. HH:mm"
        df.locale = Locale(identifier:"ko_KR")
        dateString = df.string(from: date)
        
        return dateString ?? ""
    }
    
    private func setButtonBackground() {
        CRBtnBackgroundView.frame.size = CGSize(width: CRBackgroundView.frame.height / 1.44,
                                                height: CRBackgroundView.frame.height / 7.7)
        CRBtnBackgroundView.center = CGPoint(x: CRBackgroundView.frame.width / 2,
                                             y: CRBackgroundView.frame.height * 0.925)
        CRBtnBackgroundView.backgroundColor = .clear
        CRBtnBackgroundView.image = UIImage(named: "TextBtnBackground")
        CRBackgroundView.addSubview(CRBtnBackgroundView)
    }
    
    private func setBtnIcon() {
        CRBtnIcon.frame.size = CGSize(width: CRBtnBackgroundView.frame.width / 2 * 1.2,
                                      height: CRBtnBackgroundView.frame.height * 1.3)
        CRBtnIcon.backgroundColor = .clear
        CRBtnIcon.image = UIImage(named: "TextBtn")
        CRBtnIcon.center = CGPoint(x: CRBtnBackgroundView.frame.width * 0.75,
                                   y: CRBtnBackgroundView.frame.height * 0.55)
        CRBtnBackgroundView.addSubview(CRBtnIcon)
    }
    
    private func setButtons() {
        let buttons: [UIButton : CGFloat] = [completeButton : 0.75,
                                               cancelButton : 0.28]
        
        for button in buttons {
            (button.key).frame.size = CGSize(width: CRBtnBackgroundView.frame.width / 2,
                                             height: CRBtnBackgroundView.frame.height)
            (button.key).center = CGPoint(x: CRBtnBackgroundView.frame.width * button.value,
                                          y: CRBtnBackgroundView.frame.height / 2)
            (button.key).backgroundColor = .clear
            (button.key).setTitleColor(UIColor(r: 163, g: 173, b: 178), for: .normal)
            CRBtnBackgroundView.addSubview(button.key)
        }
        cancelButton.setTitle("취소", for: .normal)
        cancelButton.titleLabel?.font = UIFont(name: "Pretendard-Regular", size: 15)
        completeButton.setTitle("완료", for: .normal)
        completeButton.titleLabel?.font = UIFont(name: "Pretendard-Regular", size: 15)
        completeButton.setTitleColor(.black, for: .normal)
    }
}

// MARK: - set CRBackroundView UI and Constraints

extension CreateRecordView {
    private func setCRBackgroundViewContraints() {
        CRBackgroundView.frame.size = CGSize(width: self.frame.width * 0.8,
                                             height: self.frame.width * 0.8 * 1.15)
        CRBackgroundView.center = CGPoint(x: self.frame.width * 0.5, y: self.frame.height * 0.38)
        if UIScreen.main.bounds.height < 820 {
            CRBackgroundView.frame.size = CGSize(width: self.frame.width * 0.8,
                                                 height: self.frame.width * 0.8)
            CRBackgroundView.center = CGPoint(x: self.frame.width * 0.5, y: self.frame.height * 0.35)
        }
    }
    
    private func setCRBackgroundViewShape() {
        CRBackgroundView.backgroundColor = .clear
        CRBackgroundView.layer.cornerRadius = 10
        
        let shadows = UIView()
        
        shadows.frame = CRBackgroundView.frame
        shadows.clipsToBounds = false
        CRBackgroundView.addSubview(shadows)
        
        let shadowPath0 = UIBezierPath(roundedRect: shadows.bounds, cornerRadius: 10)
        let layer0 = CALayer()
        
        layer0.shadowPath = shadowPath0.cgPath
        layer0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.06).cgColor
        layer0.shadowOpacity = 1
        layer0.shadowRadius = 36
        layer0.shadowOffset = CGSize(width: 6, height: 6)
        layer0.bounds = shadows.bounds
        layer0.position = shadows.center
        shadows.layer.addSublayer(layer0)
        
        let shadowPath1 = UIBezierPath(roundedRect: shadows.bounds, cornerRadius: 10)
        let layer1 = CALayer()
        
        layer1.shadowPath = shadowPath1.cgPath
        layer1.shadowColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        layer1.shadowOpacity = 1
        layer1.shadowRadius = 13
        layer1.shadowOffset = CGSize(width: -4, height: -4)
        layer1.bounds = shadows.bounds
        layer1.position = shadows.center
        shadows.layer.addSublayer(layer1)
        
        let shadowPath2 = UIBezierPath(roundedRect: shadows.bounds, cornerRadius: 10)
        let layer2 = CALayer()
        
        layer2.shadowPath = shadowPath2.cgPath
        layer2.shadowColor = UIColor(red: 0.682, green: 0.682, blue: 0.753, alpha: 0.1).cgColor
        layer2.shadowOpacity = 1
        layer2.shadowRadius = 7
        layer2.shadowOffset = CGSize(width: 4, height: 4)
        layer2.compositingFilter = "multiplyBlendMode"
        layer2.bounds = shadows.bounds
        layer2.position = shadows.center
        shadows.layer.addSublayer(layer2)
        
        let shapes = UIView()
        
        shapes.frame = CRBackgroundView.frame
        shapes.clipsToBounds = true
        CRBackgroundView.addSubview(shapes)
        
        let layer3 = CALayer()
        
        layer3.backgroundColor = UIColor(red: 0.941, green: 0.941, blue: 0.953, alpha: 1).cgColor
        layer3.bounds = shapes.bounds
        layer3.position = shapes.center
        shapes.layer.addSublayer(layer3)
        shapes.layer.cornerRadius = 10
    }
}
