//
//  ContentView.swift
//  MyCamera2
//
//  Created by ReDead on 2021/04/23.
//

import SwiftUI

struct ContentView: View {
    
    //撮影する写真を保存する状態変数
    @State var captureImage: UIImage? = nil
    //撮影画面のsheet
    @State var isShowSheet = false
    //シェア画面sheet
    @State var isShowActivity = false
    //フォトライブラリーかカメラを保持する状態変数
    @State var isPhotolibrary = false
    //ActionSheetのsheet
    @State var isShowAction = false
    
    var body: some View {
        ZStack{
            VStack{
                if let unwrapCaptureImage = captureImage {
                    //撮影写真表示
                    Image(uiImage: unwrapCaptureImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                Spacer()
                Button(action: {
                    //ActionSheetを表示
                    isShowAction = true
                }) {
                    Text("写真を撮る")
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        //文字列をセンタリング指定
                        .multilineTextAlignment(.center)
                        .background(Color.black)
                        .foregroundColor(Color.white)
                }
                .padding()
                //sheetを表示
                //isPresenteで指定した状態変数がtrueのとき実行
                .sheet(isPresented: $isShowSheet) {
                    //フォトライブラリーが選択
                    if isPhotolibrary {
                        //PHPickerViewController(フォトライブラリー)を表示
                        PHPickerView(
                            isShowSheet: $isShowSheet,
                            captureImage: $captureImage)
                    } else {
                        //UIImagePickerController(写真撮影)を表示
                        ImagePickerView(
                            isShowSheet: $isShowSheet,
                            captureImage: $captureImage)
                    }
                }
                
                //状態変数:$isShowActionの変化時実行
                .actionSheet(isPresented: $isShowAction) {
                    //ActionSheetを表示
                    ActionSheet(title: Text("確認"),
                                message: Text("選択してください"),
                                buttons: [
                                    .default(Text("カメラ"), action: {
                                        //カメラ選択
                                        isPhotolibrary = false
                                        //カメラが利用可能かチェック
                                        if UIImagePickerController.isSourceTypeAvailable(.camera){
                                            print("カメラ利用可能")
                                            //カメラ利用可能のとき
                                            isShowSheet = true
                                        }else{
                                            print("カメラ利用不可")
                                        }
                                    }),
                                    .default(Text("フォトライブラリー"), action: {
                                        //フォトライブラリー選択
                                        isPhotolibrary = true
                                        //sheet表示
                                        isShowSheet = true
                                        
                                    }),
                                    //キャンセル選択
                                    .cancel(),
                                ])
                }
                //　SNSに投稿　ボタン
                Button(action: {
                    //撮影した写真がある場合、UIActivityViewController(シェア機能)を表示
                    if let _ = captureImage {
                        isShowActivity = true
                    }
                }) {
                    Text("SNSに投稿")
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .multilineTextAlignment(.center)
                        .background(Color.black)
                        .foregroundColor(Color.white)
                }
                .padding()
                //sheet表示
                //isPresentedで指定した状態変数がtrueのとき実行
                .sheet(isPresented: $isShowActivity){
                    //UIActivityViewController(シェア機能)を表示
                    ActivityView(shareItems: [captureImage!])
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
