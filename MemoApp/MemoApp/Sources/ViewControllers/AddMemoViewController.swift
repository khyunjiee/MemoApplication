//
//  AddMemoViewController.swift
//  MemoApplication
//
//  Created by 김현지 on 2020/02/14.
//  Copyright © 2020 김현지. All rights reserved.
//

import UIKit

class AddMemoViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        
    }
    
    @IBAction func addAction(_ sender: Any) {
        let add = UIAlertController(title: "사진추가", message: "", preferredStyle: .actionSheet)
        let library = UIAlertAction(title: "앨범", style: .default) { (action) in
            self.openLibrary()
        }
        let camera = UIAlertAction(title: "카메라", style: .default) { (action) in
            self.openCamera()
        }
        let url = UIAlertAction(title: "URL로 불러오기", style: .default) { (action) in
            self.openUrl()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        add.addAction(library)
        add.addAction(camera)
        add.addAction(url)
        add.addAction(cancel)
        
        present(add, animated: true, completion: nil)
    }
    
    func openLibrary() {
        picker.sourceType = .photoLibrary
        present(picker, animated: false, completion: nil)
    }
    
    func openCamera() {
        if(UIImagePickerController .isSourceTypeAvailable(.camera)) {
            picker.sourceType = .camera
            present(picker, animated: false, completion: nil)
        }
        
        else {
            print("Camera not available")
        }
    }
    
    func openUrl() {
        let getUrl = UIAlertController(title: "URL로 불러오기", message: "", preferredStyle: .alert)
        getUrl.addTextField { (field: UITextField) in
            field.placeholder = "URL 주소를 입력해주세요."
        }
        let okAction = UIAlertAction(title: "확인", style: .default) { (action: UIAlertAction) in
            print("\(getUrl.textFields?[0].text ?? "")")
            
            let urlString = getUrl.textFields![0].text
            print("url: \(urlString!)")
            
            guard let urlAddress = URL(string: urlString!) else {return}
            
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: urlAddress) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self!.imageView.image = image
                        }
                    }
                }
            }
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        getUrl.addAction(okAction)
        getUrl.addAction(cancelAction)
        
        present(getUrl, animated: true, completion: nil)
        
    }
    
}

extension AddMemoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = image
            print(info)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
}
