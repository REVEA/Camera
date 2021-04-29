//
//  ActivityView.swift
//  MyCamera2
//
//  Created by ReDead on 2021/04/23.
//

import SwiftUI

struct ActivityView: UIViewControllerRepresentable {
    
    //シェアする写真
    let shareItems: [Any]
    
    //表示するViewを生成するとき実行
    func makeUIViewController(context: Context) ->UIActivityViewController {
        //UIActivityViewControllerでシェアする機能を生成
        let controller = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        //UIActivityViewControllerを返す
        return controller
    }
    
    //Viewが更新されたときに実行
    func updateUIViewController(_ uiViewController: UIActivityViewController,
                                context: UIViewControllerRepresentableContext<ActivityView>)
    {
        //
    }
    
}
