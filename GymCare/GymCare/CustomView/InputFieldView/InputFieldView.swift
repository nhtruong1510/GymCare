//
//  InputFieldView.swift
//  AppPit
//
//  Created by Nguyễn Hà on 03/08/2022.
//

import UIKit

class InputFieldView: BaseView {

    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var inputTextField: UITextField!
    @IBOutlet private weak var alertView: UIView!
    @IBOutlet private weak var alertLabel: UILabel!
    @IBOutlet private weak var infoButton: UIButton!

    var editingCallBack: ((String?) -> (Void))?
    var endEdittingCallBack: ((String?) -> (Void))?
    weak var controller: BaseViewController?

    private var datePicker: UIDatePicker?
    private let dot = "."

    var value: String? {
        set(value) {
            if isFormatMoney {
                inputTextField.text = value?.formatMoney()
            } else {
                inputTextField.text = value
            }
        }
        get {
            if isFormatMoney {
                if castToString(inputTextField.text).isEmpty {
                    return nil
                }
                return getValue(text: inputTextField.text)
            }
            let value = inputTextField.text?.trimmingCharacters(in: .whitespaces)
            if castToString(value).isEmpty {
                return nil
            }
            return value
        }
    }

    @IBInspectable
    var defaultValue: String? {
        didSet {
            inputTextField.text = defaultValue
        }
    }

    @IBInspectable
    var number: String? {
        didSet{
            alertLabel.text = number
            alertView.isHidden = number == nil
        }
    }
    
    @IBInspectable
    var title: String? {
        didSet{
            titleLabel.text = title
        }
    }

    @IBInspectable
    var secureTextEntry: Bool = false {
        didSet {
            inputTextField.isSecureTextEntry = secureTextEntry
        }
    }

    @IBInspectable
    var isNote: Bool = false {
        didSet {
            if isNote {
                guard !castToString(titleLabel.text).contains(" *") else { return }
                let title = castToString(titleLabel.text) + " *"
                let amountText = NSMutableAttributedString.init(string: title)
                let range = (title as NSString).range(of: " *")
                amountText.setAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
                                          NSAttributedString.Key.foregroundColor: UIColor.red],
                                         range: range)
                titleLabel.attributedText = amountText
            } else {
                titleLabel.text = titleLabel.text?.replacingOccurrences(of: " *", with: "")
            }
        }
    }

    @IBInspectable
    var keyboard: Int = 0 {
        didSet {
            inputTextField.keyboardType = UIKeyboardType.init(rawValue: keyboard)!
            
        }
    }

    @IBInspectable
    var editingIsAllow: Bool = true {
        didSet {
            inputTextView.isUserInteractionEnabled = editingIsAllow
            inputTextView.backgroundColor = editingIsAllow ? UIColor.white : UIColor.lightGray
            inputTextField.textColor = editingIsAllow ? .black : .darkGray
        }
    }

    @IBInspectable
    var isFormatMoney: Bool = false

    @IBInspectable
    var maxLength: Int = 150

    @IBInspectable
    var hiddenInfoButton: Bool = true {
        didSet {
            infoButton.isHidden = hiddenInfoButton
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        Bundle.main.loadNibNamed("InputFieldView", owner: self, options: nil)
        self.addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

    private func getValue(text: String?) -> String? {
        if isFormatMoney {
            return text?.replacingOccurrences(of: dot, with: "")
        }
        return text
    }

    @IBAction private func edttingChanged(_ sender: UITextField) {
        let text = sender.text
        if isFormatMoney {
            let value = getValue(text: text)
            inputTextField.text = value?.formatMoney()
        } else {
            inputTextField.text = text
        }
        if let edttingChanged = editingCallBack {
            if isFormatMoney {
                edttingChanged(getValue(text: inputTextField.text))
            } else {
                edttingChanged(inputTextField.text?.trimmingCharacters(in: .whitespaces))
            }
        }
    }

    @IBAction private func editingBegin(_ sender: UITextField) {
        status = .active
        if defaultValue != nil, sender.text == "0" {
            self.inputTextField.text = nil
        }
    }

    @IBAction private func editingEnd(_ sender: UITextField) {
        status = .inactive
        if defaultValue != nil, castToString(sender.text).isEmpty {
            self.inputTextField.text = defaultValue
        }
    }
}

extension InputFieldView: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = inputTextField.text,
            let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        if inputTextField.keyboardType == .decimalPad, (string == "," || string == "."), count <= maxLength {
            let currentText = castToString(inputTextField.text)
            if currentText.count == 0 || currentText.contains(".") {
                return false
            }
            inputTextField.text = textFieldText + "."
            return false
        }
        return count <= maxLength
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let endEdittingCallBack = endEdittingCallBack {
            endEdittingCallBack(getValue(text: textField.text))
        }
    }
}
