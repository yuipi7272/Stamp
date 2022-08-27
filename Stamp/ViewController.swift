//
//  ViewController.swift
//  Stamp
//
//  Created by Yui Ogawa on 2022/08/27.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // スタンプ画像の名前が入った配列
    var imageNameArray: [String] = ["hana", "hoshi", "onpu", "shitumon"]
    // 選択しているスタンプ画像の番号
    var imageIndex: Int = 0
    // 背景画像を表示させるImageView
    @IBOutlet var haikeiImageView: UIImageView!
    // スタンプ画像が入るImageView
    var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    // ■ タッチイベントの動作
    // タッチされたとき
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // もしimageIndexが0でない(押すスタンプが選ばれている)とき
        if imageIndex != 0 {
            // スタンプサイズを40pxの正方形に指定
            imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            
            // 押されたスタンプの画像を指定
            let image: UIImage = UIImage(named: imageNameArray[imageIndex - 1])!
            imageView.image = image
        }
    }
    // ドラッグ & ドロップで移動しているとき
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // タッチされた位置を取得
        let touch: UITouch = touches.first!
        let location: CGPoint = touch.location(in: self.view)
        
        // タッチされた位置に画像を置く
        imageView.center = CGPoint(x: location.x, y: location.y)
        
        // 画像を表示する
        self.view.addSubview(imageView)
    }
    // ■ スタンプ用のボタン宣言
    @IBAction func selectedFirst(){
        imageIndex = 1
    }
    @IBAction func selectedSecond(){
        imageIndex = 2
    }
    @IBAction func selectedThird(){
        imageIndex = 3
    }
    @IBAction func selectedFourth(){
        imageIndex = 4
    }
    
    // ■ 戻るボタン
    @IBAction func back(){
        self.imageView.removeFromSuperview()
    }

    // ■ 画像ボタン
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // imageに選んだ画像を設定する
        let image = info[.originalImage] as? UIImage
        
        // imageを背景に設定する
        haikeiImageView.image = image
        
        // フォトライブラリを閉じる
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func selectBackground(){
        // UIImagePickerControllerのインスタンスを作成
        let imagePickerController: UIImagePickerController = UIImagePickerController()
        
        // フォトライブラリを使う設定
        imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        
        // フォトライブラリを呼び出す
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    // ■ 保存ボタン
    @IBAction func save(){
        // 画面のスクリーンショットを取得
        let rect: CGRect = CGRect(x: 0, y: 30, width: 320, height: 380)
        UIGraphicsBeginImageContext(rect.size)
        self.view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let capture = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // フォトライブラリに保存
        UIImageWriteToSavedPhotosAlbum(capture!, nil, nil, nil)
    }
}

