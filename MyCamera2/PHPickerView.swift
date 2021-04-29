//
//  PHPickerView.swift
//  MyCamera2
//
//  Created by ReDead on 2021/04/24.
//

import SwiftUI
import PhotosUI

struct PHPickerView: UIViewControllerRepresentable {
    
    //Viewが更新時実行
    func updateUIViewController(
        _ uiViewController: PHPickerViewController,
        context: UIViewControllerRepresentableContext<PHPickerView>)
    {
        //
    }
    
    //sheetが表示されてるか
    @Binding var isShowSheet: Bool
    //フォトライブラリーから読み込み写真
    @Binding var captureImage: UIImage?
    
    //Coordinatorでコントローラーのdelegateを管理
    class Coordinator: NSObject,
                       PHPickerViewControllerDelegate {
        //PHPickerView型の変数
        var parent: PHPickerView
        //イニシャライザ
        init(parent: PHPickerView) {
            self.parent = parent
        }
        //フォトライブラリーで写真を 選択/キャンセル 時に実行
        //delegate メソッド 絶対必要
        func picker(
            _ picker: PHPickerViewController,
            didFinishPicking results: [PHPickerResult]) {
            
            //写真は1つだけ選べる設定、最初の１つを指定
            if let result = results.first {
                //UIImage型の写真のみ非同期で取得
                result.itemProvider.loadObject(ofClass: UIImage.self) {
                    (image, error) in
                    //写真が取得できたら
                    if let unwrapImage = image as? UIImage {
                        //選択された写真を追加
                        self.parent.captureImage = unwrapImage
                    }else {
                        print("使用できる写真がありません")
                    }
                }
            } else {
                print("選択された写真はないです")
            }
            // sheetを閉じる
            parent.isShowSheet = false
        }
    }
    
    //Coordinatorを生成、SwiftUIで自動呼び出し
    func makeCoordinator() -> Coordinator {
        //Coordinatorクラスのインスタンス生成
        Coordinator(parent: self)
    }
    
    //Viewを生成するときに実行
    func makeUIViewController(
        context:UIViewControllerRepresentableContext<PHPickerView>)
    -> PHPickerViewController {
        //PHPickerViewControllerのカスタマイズ
        var configuration = PHPickerConfiguration()
        //静止画選択
        configuration.filter = .images
        //フォトライブラリーで選択できる枚数を1枚に設定
        configuration.selectionLimit = 1
        //PHPickerViewControllerのインスタンス生成
        let picker = PHPickerViewController(configuration: configuration)
        //delagate設定
        picker.delegate = context.coordinator
        //PHPickerViewControllerを返す
        return picker
    }
    

}
