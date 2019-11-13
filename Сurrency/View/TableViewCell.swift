    //
    //  TableViewCell.swift
    //  Сurrency
    //
    //  Created by Алексей Евменьков on 9/10/19.
    //  Copyright © 2019 MyCompany. All rights reserved.
    //
    
    import UIKit
    
    protocol PassTextDelegate: class {
        func passText(text: String?)
    }
    
    class TableViewCell: UITableViewCell {
        @IBOutlet weak var mainView: UIView!
        
        @IBOutlet private weak var bynTextField: UITextField!
        weak var delegate: PassTextDelegate?
        
        override func awakeFromNib() {
            super.awakeFromNib()
            bynTextField.delegate = self
            
        }
        
    }
    // MARK: - UITextFieldDelegate
    extension TableViewCell: UITextFieldDelegate {
        func textField(_ textField: UITextField,
                       shouldChangeCharactersIn range: NSRange,
                       replacementString string: String) -> Bool {
            guard let text = textField.text,
            let range = Range(range, in: text) else { return false }
            let currentText = text.replacingCharacters(in: range, with: string)
            delegate?.passText(text: currentText)
            return true
        }
    }
