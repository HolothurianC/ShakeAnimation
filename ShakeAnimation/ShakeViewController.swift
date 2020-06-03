//
//  ShakeViewController.swift
//  ShakeAnimation
//
//  Created by Holo on 2020/6/3.
//  Copyright © 2020 Holo. All rights reserved.
//

import UIKit

class ShakeViewController: UIViewController {
    let ScreenWidth = UIScreen.main.bounds.size.width
    let ScreenHeight = UIScreen.main.bounds.size.height
    var nextBtn:UIButton = UIButton(type: .custom)
    var sourceTimer:DispatchSourceTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.layoutButton()
    }
    
    func layoutButton(){
        nextBtn.frame = CGRect(x: ScreenWidth/2.0 - 20, y:ScreenHeight/2.0 - 20, width: 40, height: 40)
        nextBtn.backgroundColor = .purple
        nextBtn.addTarget(self, action: #selector(nextPageAction), for: .touchUpInside)
        view.addSubview(nextBtn)
    }
    
    @objc func nextPageAction(){
        self.present(NextViewController(), animated: true, completion: nil)
    }
    
    func shakeAnimation(layer:CALayer,repeateCount:Float,duration:CFTimeInterval,values:[Any]){
        let shakeAnimation = CAKeyframeAnimation()
        shakeAnimation.keyPath = "transform.rotation"
        shakeAnimation.values = values
        shakeAnimation.delegate = self
        shakeAnimation.duration = duration
        shakeAnimation.repeatCount = repeateCount
        shakeAnimation.isRemovedOnCompletion = false
        layer.add(shakeAnimation, forKey: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sourceTimer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.global())
        sourceTimer?.schedule(deadline: DispatchTime.now()+1, repeating: DispatchTimeInterval.seconds(2), leeway: .milliseconds(1))
        sourceTimer?.setEventHandler(handler: {[weak self]  in
            DispatchQueue.main.async {
                //'M_PI' is deprecated: Please use 'Double.pi' or '.pi' to get the value of correct type and avoid casting.
                //已踩：更换为Double.pi后会造成内存泄漏
                self?.shakeAnimation(layer: self?.nextBtn.layer ?? CALayer(), repeateCount: 3, duration: 0.2, values: [-M_PI/12,M_PI/12,-M_PI/12])
                print("Animationing \(NSDate())")
            }
        })
        sourceTimer?.resume()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sourceTimer?.cancel()
        sourceTimer = nil
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

extension ShakeViewController : CAAnimationDelegate{
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            self.nextBtn.layer.removeAnimation(forKey: "transform.rotation")
            print("Remove nextBtn current animation")
        }
    }
}
