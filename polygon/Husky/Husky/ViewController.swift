//
//  ViewController.swift
//  Husky
//
//  Created by HanhVo on 6/8/16.
//  Copyright © 2016 HanhVo. All rights reserved.
//

import UIKit

enum MenuItemType : Int {
    
    case _Normal = 999
    case _3Slides = 3
    case _4Slides = 4
    case _5Slides = 5
    case _6Slides = 6
    case _7Slides = 7
    
    
}


class ViewController: UIViewController,
                      UIImagePickerControllerDelegate,
                      UINavigationControllerDelegate,
                      MenuDelegate
{
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var optionsButton: Menu!
    @IBOutlet weak var photoButton: UIButton!
    
    
    let imagePicker = UIImagePickerController()
    var items: [(icon: String, color: UIColor)]?
    var pickedImage: UIImage?
    
    
    // MARK: - View Lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        configForBeginning()
    }
    
    // MARK: Method
    func configForBeginning() {
        
        //imagePicker
        imagePicker.delegate = self
        
        //MenuItem
         items = [
                ("3slides", UIColor(red:0.19, green:0.57, blue:1, alpha:1)),
                ("4slides", UIColor(red:0.22, green:0.74, blue:0, alpha:1)),
                ("5slides", UIColor(red:0.96, green:0.23, blue:0.21, alpha:1)),
                ("6slides", UIColor(red:0.51, green:0.15, blue:1, alpha:1)),
                ("7slides", UIColor(red:1, green:0.39, blue:0, alpha:1)),
        ]
        
        // optionsButton
        optionsButton.hidden = true
    }
    
    func handleForImage(index:Int) {
        
        // crop image with shape
        let menuType: MenuItemType? =  indexToMenuType(index)
        let squareImage = pickedImage?.cropToBounds(pickedImage!.size)
        let outputImage = squareImage?.imageMaskedWithPolygon((menuType?.rawValue)!)
        imageView.image = outputImage;
        
        // hide options button & show photobutton
        photoButton.hidden = false
        optionsButton.hidden = true
    }
    
    func indexToMenuType(index:Int) -> MenuItemType {
        
        switch index {
        case 0:
            return ._3Slides
        case 1:
            return ._4Slides
        case 2:
           return  ._5Slides
        case 3:
            return ._6Slides
        case 4:
            return  ._7Slides
        default:
            return  ._Normal
        }

    }
    
    // MARK: Actions
    @IBAction func photo(sender: AnyObject) {
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: MenuDelegate
    func menu(menu: Menu, willDisplay button: UIButton, atIndex: Int) {
        
        button.backgroundColor = items![atIndex].color
        button.setImage(UIImage(imageLiteral: items![atIndex].icon), forState: .Normal)
        
        // set highlited image
        let highlightedImage  = UIImage(imageLiteral: items![atIndex].icon).imageWithRenderingMode(.AlwaysTemplate)
        button.setImage(highlightedImage, forState: .Highlighted)
        button.tintColor = UIColor.init(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.3)
    }
    
    func menu(menu: Menu, buttonDidSelected button: UIButton, atIndex: Int) {
        
        handleForImage(atIndex)
    }

    // MARK: - UIImagePickerControllerDelegate Methods
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        if (pickedImage != nil) {
            
            pickedImage = nil
        }
        
        // get image from photo
        pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        imageView.contentMode = .ScaleAspectFit
        imageView.image = pickedImage
        
        // show options button & hide photobutton
        photoButton.hidden = true
        optionsButton.hidden = false
        
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
