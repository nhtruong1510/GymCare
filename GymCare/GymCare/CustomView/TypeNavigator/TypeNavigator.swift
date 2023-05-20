//
//  TypeNavigator.swift
//  GymCare
//
//  Created by Nguyễn Hà on 31/12/2022.
//

import UIKit

protocol TypeNavigatorDelegate {
    func getSearchText(text: String?)
}

class TypeNavigator: UIView {
    
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var searchView: UIView!
    @IBOutlet private weak var searchBtnView: UIView!
    @IBOutlet private weak var backBtnView: UIView!
    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dateView: UIView!
    
    var onClickBack: (() -> Void)?
    var onClickDate: (() -> Void)?
    var onClickSearch: (() -> Void)?
    var onClickCloseSearch: (() -> Void)?
    var searchAction: ((String?) -> Void)?
    var delegate: TypeNavigatorDelegate?
    var isShowIconSearch: Bool?
    
    @IBInspectable
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    @IBInspectable
    var isBackButton: Bool = false {
        didSet {
            backBtnView.isHidden = !isBackButton
        }
    }
    
    @IBInspectable
    var isSearchButton: Bool = false {
        didSet {
            searchBtnView.isHidden = !isSearchButton
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
        Bundle.main.loadNibNamed("TypeNavigator", owner: self, options: nil)
        self.addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        searchTextField.addTarget(self, action: #selector(searchClass), for: .editingChanged)
    }
    
    @objc private func searchClass() {
        if let searchAction = searchAction {
            searchAction(searchTextField.text)
        }
    }
    
    func setTitle(title: String?) {
        titleLabel.text = title
    }
    
    func showBackButton(isShow: Bool) {
        backBtnView.isHidden = !isShow
    }
    
    func showSearchButton(isShow: Bool) {
        searchBtnView.isHidden = !isShow
    }
    
    func isShowSearch() {
        if !searchView.isHidden && searchBtnView.isHidden {
            closeSearch()
            searchBtnView.isHidden = true
            dateView.isHidden = false
        } else {
            isShowIconSearch = true
            showSearch()
            dateView.isHidden = true
        }
    }
    
    func showSearch() {
        searchView.isHidden = false
        searchBtnView.isHidden = true
        if let onClick = onClickSearch {
            onClick()
        }
    }
    
    func closeSearch() {
        searchView.isHidden = true
        searchBtnView.isHidden = isShowIconSearch ?? false
        self.endEditing(true)
        if let onClick = onClickCloseSearch {
            onClick()
        }
    }
    
    @IBAction private func onClickBack(_ sender: Any) {
        if let onClick = onClickBack {
            onClick()
        }
    }
    
    @IBAction private func onClickSearch(_ sender: Any) {
        showSearch()
    }
    
    @IBAction private func onClickCloseSearch(_ sender: Any) {
        closeSearch()
    }
    
    @IBAction private func editingChanged(_ sender: Any) {
        delegate?.getSearchText(text: searchTextField.text)
    }
    
    @IBAction private func chooseDate(_ sender: Any) {
        if let onClick = onClickDate {
            onClick()
        }
    }
}


