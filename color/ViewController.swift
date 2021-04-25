//
//  ViewController.swift
//  color
//
//  Created by 簡吟真 on 2021/4/25.
//

import UIKit

class ViewController: UIViewController {
    // 圖片：背景、帽子純色（mask前）
    @IBOutlet weak var BackgroundImageView: UIImageView!
    @IBOutlet weak var headView: UIView!
    @IBOutlet weak var starView: UIView!
    // 圖片：花紋圖片
    @IBOutlet weak var giraffeView: UIImageView!
    @IBOutlet weak var tigerView: UIImageView!
    // 局部調整 選擇變色物件的SegmentedControl
    @IBOutlet weak var changeSegmented: UISegmentedControl!
    // 局部調整 顏色Slider
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var alphaSlider: UISlider!
    // 局部調整 顯示顏色對應數值的Label
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    @IBOutlet weak var alphaLabel: UILabel!
    // 局部調整 花色
    @IBOutlet weak var patternSwitch: UISwitch!
    @IBOutlet weak var giraffeButton: UIButton!
    @IBOutlet weak var tigerButton: UIButton!
    // 圖片調整 三個Slider＆陰影view
    @IBOutlet weak var radiusSlider: UISlider!
    @IBOutlet weak var borderSlider: UISlider!
    @IBOutlet weak var shadowSlider: UISlider!
    @IBOutlet weak var shadowView: UIView!
    
    // 用變數來儲存 帽子、背景、邊框三種物件的各項調整值（此為初始值，使用者調整過Slider後則會存入新的值）
       var headRed: Float = 47/255
       var headGreen: Float = 44/255
       var headBlue:Float = 63/255
       var headAlpha: Float = 1
       var bgRedValue: Float = 247/255
       var bgGreenValue: Float = 253/255
       var bgBlueValue: Float = 119/255
       var bgAlphaValue: Float = 1
       var borderRedValue: Float = 0
       var borderGreenValue: Float = 0
       var borderBlueValue: Float = 0
       var borderAlphaValue: Float = 1
       
       // 花色狀態儲存（判斷是否開啟花色）
       var patternSwitchs = false
       var giraffeButtons = false
       var tigerButtons = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let headImageView = UIImageView(image: UIImage(named: "head"))
                 headImageView.frame = headView.bounds
                 headImageView.contentMode = .scaleAspectFill
                 headView.mask = headImageView
    }
    // 自定function區
        // 顯示顏色對應數值於Label上，原本value只有 0-1，乘以255讓數值較直觀（一般使用者選色是用 R: 30/255 不會記 0.12）
        func colorValueLabelShow(){
            redLabel.text = String(format: "%.0f", redSlider.value * 255)
            greenLabel.text = String(format: "%.0f", greenSlider.value * 255)
            blueLabel.text = String(format: "%.0f", blueSlider.value * 255)
            alphaLabel.text = String(format: "%.1f", alphaSlider.value)
}
    // 每次變動顏色後將對應的value儲存至原本變數中（帽子、背景、邊框各一）
        func headColorSave(){
            headRed = redSlider.value
            headGreen = greenSlider.value
            headBlue = blueSlider.value
            headAlpha = alphaSlider.value
        }
        func bgColorValueSave(){
            bgRedValue = redSlider.value
            bgGreenValue = greenSlider.value
            bgBlueValue = blueSlider.value
            bgAlphaValue = alphaSlider.value
        }
        func borderColorValueSave(){
            borderRedValue = redSlider.value
            borderGreenValue = greenSlider.value
            borderBlueValue = blueSlider.value
            borderAlphaValue = alphaSlider.value
        }
    
    // 用已儲存進變數的Value（新的顏色數值）讓Slider跳至相對應的位置
       func headColorSliderSet(){
           redSlider.setValue(headRed, animated: true)
           greenSlider.setValue(headGreen, animated: true)
           blueSlider.setValue(headBlue, animated: true)
           alphaSlider.setValue(headAlpha, animated: true)
       }
       func bgColorSliderSet(){
           redSlider.setValue(bgRedValue, animated: true)
           greenSlider.setValue(bgGreenValue, animated: true)
           blueSlider.setValue(bgBlueValue, animated: true)
           alphaSlider.setValue(bgAlphaValue, animated: true)
       }
       func borderColorSliderSet(){
           redSlider.setValue(borderRedValue, animated: true)
           greenSlider.setValue(borderGreenValue, animated: true)
           blueSlider.setValue(borderBlueValue, animated: true)
           alphaSlider.setValue(borderAlphaValue, animated: true)
       }
    
    // 確認花色Switch狀態（開啟時切換到其他SegmentedControl回來也還會開啟）
        func patternSwitchCheck(){
            patternSwitch.isOn = patternSwitchs
            patternSwitch.isEnabled = true
            giraffeButton.isHidden = !patternSwitchs
            tigerButton.isHidden = !patternSwitchs
        }
    // 切換到調整背景及邊框的SegmentedControl時，Switch無法使用及開啟＋花紋按鈕隱藏
    func patternSwitchUnableAndOff(){
        patternSwitch.isOn = false
        patternSwitch.isEnabled = false
        giraffeButton.isHidden = true
        tigerButton.isHidden = true
        }
    
    // IBAction Start
        // 按Segment control欄位選物件 觸發的所有動作
        @IBAction func segmentControlChanged(_ sender: Any) {
            if changeSegmented.selectedSegmentIndex == 0{
                headView.backgroundColor = UIColor(red: CGFloat(headRed), green: CGFloat(headGreen), blue: CGFloat(headBlue), alpha: CGFloat(headAlpha))
                headColorSliderSet()
                
                patternSwitchCheck()
            }
            else if changeSegmented.selectedSegmentIndex == 1{
                BackgroundImageView.backgroundColor = UIColor(red: CGFloat(bgRedValue), green: CGFloat(bgGreenValue), blue: CGFloat(bgBlueValue), alpha: CGFloat(bgAlphaValue))
                bgColorSliderSet()
                
                patternSwitchUnableAndOff()
            }
            else if changeSegmented.selectedSegmentIndex == 2{
                BackgroundImageView.layer.borderColor = CGColor(red: CGFloat(borderRedValue), green: CGFloat(borderGreenValue), blue: CGFloat(borderBlueValue), alpha: CGFloat(borderAlphaValue))
                borderColorSliderSet()
                
                patternSwitchUnableAndOff()
            }
            colorValueLabelShow()
        }

    // 調顏色區（注意：每調整一次Slider就要儲存新的值進變數中）並用if else判斷要調哪個物件的顏色
        // Slider更動
        @IBAction func colorSliderChange(_ sender: Any) {
            if changeSegmented.selectedSegmentIndex == 0{
                headView.backgroundColor = UIColor(red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: CGFloat(alphaSlider.value))
                headColorSave()
            }
            else if changeSegmented.selectedSegmentIndex == 1{
                BackgroundImageView.backgroundColor = UIColor(red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: CGFloat(alphaSlider.value))
                bgColorValueSave()
            }
            else if changeSegmented.selectedSegmentIndex == 2{
                BackgroundImageView.layer.borderColor = CGColor(red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: CGFloat(alphaSlider.value))
                borderColorValueSave()
            }
            colorValueLabelShow()
        }
    // 全部隨機按鈕
        @IBAction func allRandomButtonClicked(_ sender: Any) {
            redSlider.value = Float.random(in: 0...1)
            greenSlider.value = Float.random(in: 0...1)
            blueSlider.value = Float.random(in: 0...1)
            alphaSlider.value = Float.random(in: 0.1...1)
            if changeSegmented.selectedSegmentIndex == 0{
                headView.backgroundColor = UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: CGFloat.random(in: 0.1...1))
                headColorSave()
            }
            else if changeSegmented.selectedSegmentIndex == 1{
                BackgroundImageView.backgroundColor = UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: CGFloat.random(in: 0.1...1))
                bgColorValueSave()
            }
            else if changeSegmented.selectedSegmentIndex == 2{
                BackgroundImageView.layer.borderColor = CGColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: CGFloat.random(in: 0.1...1))
                borderColorValueSave()
            }
            colorValueLabelShow()
        }
    // 各選項隨機按鈕（紅、綠、藍、透明度各一）
        @IBAction func redRandomButtonClicked(_ sender: Any) {
            redSlider.value = Float.random(in: 0...1)
            redLabel.text = String(format: "%.0f", redSlider.value * 255)
            if changeSegmented.selectedSegmentIndex == 0{
                headView.backgroundColor = UIColor(red: CGFloat.random(in: 0...1), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: CGFloat(alphaSlider.value))
                headColorSave()
            }
            else if changeSegmented.selectedSegmentIndex == 1{
                BackgroundImageView.backgroundColor = UIColor(red: CGFloat.random(in: 0...1), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: CGFloat(alphaSlider.value))
                bgColorValueSave()
            }
            else if changeSegmented.selectedSegmentIndex == 2{
                BackgroundImageView.layer.borderColor = CGColor(red: CGFloat.random(in: 0...1), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: CGFloat(alphaSlider.value))
                borderColorValueSave()
            }
        }
        
        @IBAction func greenRandomButtonClicked(_ sender: Any) {
            greenSlider.value = Float.random(in: 0...1)
            greenLabel.text = String(format: "%.0f", greenSlider.value * 255)
            if changeSegmented.selectedSegmentIndex == 0{
                headView.backgroundColor = UIColor(red: CGFloat(redSlider.value), green: CGFloat.random(in: 0...1), blue: CGFloat(blueSlider.value), alpha: CGFloat(alphaSlider.value))
                headColorSave()
            }
            else if changeSegmented.selectedSegmentIndex == 1{
                BackgroundImageView.backgroundColor = UIColor(red: CGFloat(redSlider.value), green: CGFloat.random(in: 0...1), blue: CGFloat(blueSlider.value), alpha: CGFloat(alphaSlider.value))
                bgColorValueSave()
            }
            else if changeSegmented.selectedSegmentIndex == 2{
                BackgroundImageView.layer.borderColor = CGColor(red: CGFloat(redSlider.value), green: CGFloat.random(in: 0...1), blue: CGFloat(blueSlider.value), alpha: CGFloat(alphaSlider.value))
                borderColorValueSave()
            }
        }
        
        @IBAction func blueRandomButtonClicked(_ sender: Any) {
            blueSlider.value = Float.random(in: 0...1)
            blueLabel.text = String(format: "%.0f", blueSlider.value * 255)
            if changeSegmented.selectedSegmentIndex == 0{
                headView.backgroundColor = UIColor(red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat.random(in: 0...1), alpha: CGFloat(alphaSlider.value))
                headColorSave()
            }
            else if changeSegmented.selectedSegmentIndex == 1{
                BackgroundImageView.backgroundColor = UIColor(red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat.random(in: 0...1), alpha: CGFloat(alphaSlider.value))
                bgColorValueSave()
            }
            else if changeSegmented.selectedSegmentIndex == 2{
                BackgroundImageView.layer.borderColor = CGColor(red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat.random(in: 0...1), alpha: CGFloat(alphaSlider.value))
                borderColorValueSave()
            }
        }
        
        @IBAction func alphaRandomButtonClicked(_ sender: Any) {
            alphaSlider.value = Float.random(in: 0.1...1)
            alphaLabel.text = String(format: "%.1f", alphaSlider.value)
            if changeSegmented.selectedSegmentIndex == 0{
                headView.backgroundColor = UIColor(red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: CGFloat.random(in: 0.1...1))
                headColorSave()
            }
            else if changeSegmented.selectedSegmentIndex == 1{
                BackgroundImageView.backgroundColor = UIColor(red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: CGFloat.random(in: 0.1...1))
                bgColorValueSave()
            }
            else if changeSegmented.selectedSegmentIndex == 2{
                BackgroundImageView.layer.borderColor = CGColor(red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: CGFloat.random(in: 0.1...1))
                borderColorValueSave()
            }
        }
    
    // 重新調色按鈕（跳回該物件原本預設顏色）
        @IBAction func resetButtonClick(_ sender: UIButton) {
            if changeSegmented.selectedSegmentIndex == 0{
                headRed = 255/255
                headGreen = 255/255
                headBlue = 255/255
                headAlpha = 1
                headColorSliderSet()
                headView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
                headColorSave()
                patternSwitch.isEnabled = true
            }
            else if changeSegmented.selectedSegmentIndex == 1{
                bgRedValue = 255/255
                bgGreenValue = 255/255
                bgBlueValue = 255/255
                bgAlphaValue = 1
                bgColorSliderSet()
                headView.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0)
                BackgroundImageView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue:255/255, alpha: 1)
                bgColorValueSave()
                
                patternSwitchUnableAndOff()
            }
            else if changeSegmented.selectedSegmentIndex == 2{
                borderRedValue = 0
                borderGreenValue = 0
                borderBlueValue = 0
                borderAlphaValue = 1
                borderColorSliderSet()
                headView.layer.borderColor = UIColor.black.cgColor
                borderColorValueSave()
                
                patternSwitchUnableAndOff()
            }
            colorValueLabelShow()
        }
    // 調花色區
        // 開關On時顯示按鈕
        @IBAction func patternSwitchOn(_ sender: UISwitch) {
            if sender.isOn{
                giraffeButton.isHidden = false
                tigerButton.isHidden = false
                patternSwitchs = true
            }else{
                giraffeButton.isHidden = true
                tigerButton.isHidden = true
                giraffeView.isHidden = true
                tigerView.isHidden = true
                patternSwitchs = false
                giraffeButtons = false
                tigerButtons = false
            }
        }
    // 按鈕顯示花紋（讓原本已隱藏的花紋圖片取消隱藏）
       @IBAction func giraffPatternButtonClick(_ sender: Any) {
        giraffeView.isHidden = false
        tigerView.isHidden = true
        giraffeView.frame = headView.bounds
        headView.addSubview(giraffeView)
        giraffeButtons = true
        tigerButtons = false
       }
       
       @IBAction func tigerPatternButtonClick(_ sender: Any) {
        tigerView.isHidden = true
        giraffeView.isHidden = false
        tigerView.frame = headView.bounds
        headView.addSubview(tigerView)
        giraffeButtons = false
        tigerButtons = true
       }
    // 圖片調整區
        // 選項開關On時顯示該選項的調節Slider
        @IBAction func pictureRadiusSwitchOn(_ sender: UISwitch) {
            if sender.isOn{
                radiusSlider.isHidden = false
                BackgroundImageView.layer.cornerRadius = CGFloat(radiusSlider.value)
                shadowView.layer.cornerRadius = CGFloat(radiusSlider.value)
            }else{
                radiusSlider.isHidden = true
                BackgroundImageView.layer.cornerRadius = 0
                
            }
        }
        
        @IBAction func pictureBoderSwitchOn(_ sender: UISwitch) {
            if sender.isOn{
                borderSlider.isHidden = false
                BackgroundImageView.layer.borderColor = CGColor(red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: CGFloat(alphaSlider.value))
            }else{
                borderSlider.isHidden = true
                BackgroundImageView.layer.borderColor = UIColor.clear.cgColor
            }
        }
        
        @IBAction func pictureShadowSwitchOn(_ sender: UISwitch) {
            if sender.isOn{
                shadowSlider.isHidden = false
                shadowView.layer.shadowOffset = CGSize(width: 5, height: 5)
                shadowView.layer.shadowColor = UIColor.darkGray.cgColor
                shadowView.layer.shadowOpacity = 0.5
            }else{
                shadowSlider.isHidden = true
                shadowView.layer.shadowOpacity = 0
            }
        }
        
        // 各選項Slider更動
        @IBAction func radiusSliderChange(_ sender: Any) {
            BackgroundImageView.layer.cornerRadius = CGFloat(radiusSlider.value)
                    shadowView.layer.cornerRadius = CGFloat(radiusSlider.value)
        }
    
        @IBAction func borderSliderChange(_ sender: UISlider) {
            BackgroundImageView.clipsToBounds = true
            BackgroundImageView.layer.borderWidth = CGFloat(borderSlider.value)
        }
    
        @IBAction func shadowSliderChange(_ sender: Any) {
            shadowView.layer.shadowRadius = CGFloat(shadowSlider.value)
        }
    }
