//
//  CameraRepresentableView.swift
//  Diptych
//
//  Created by 윤범태 on 2023/07/13.
//

import SwiftUI

struct CameraRepresentableView: UIViewControllerRepresentable {
    @StateObject var viewModel: TodayDiptychViewModel
    
    func makeUIViewController(context: Context) -> CameraViewController {
        let cameraStoryboard = UIStoryboard(name: "CameraStoryboard", bundle: nil)
        let viewController =  cameraStoryboard.instantiateViewController(withIdentifier: "CameraViewController") as! CameraViewController
        viewController.viewModel = viewModel
        
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: CameraViewController, context: Context) {}
    
    typealias UIViewControllerType = CameraViewController
    
}

struct CameraRepresentableView_Previews: PreviewProvider {
    static var viewModel = TodayDiptychViewModel()
    static var previews: some View {
        CameraRepresentableView(viewModel: viewModel)
            .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
            .previewDisplayName("iPhone 14")
        CameraRepresentableView(viewModel: viewModel)
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro Max"))
            .previewDisplayName("iPhone 14 Pro Max")
    }
}
