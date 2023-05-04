//
//  NotiView.swift
//  SchoolUpTeacher
//
//  Created by Nguyễn Hà on 01/01/2023.
//

import UIKit

class NotiView: UIView {

    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var tableView: ContentSizedTableView!
    @IBOutlet private weak var moreButton: UIButton!
    @IBOutlet private weak var emptyLabel: UILabel!

    private var notis: [Time] = []
    var onClickNoti: ((Int?) -> Void)?
    var onClickMore: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
    }

    private func setupView() {
        Bundle.main.loadNibNamed("NotiView", owner: self, options: nil)
        self.addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.registerCells(from: .notiViewCell)
    }

    func reloadData(notis: [Time]) {
        emptyLabel.isHidden = notis.count != 0
        moreButton.isHidden = notis.count == 0
        self.notis = notis
        tableView.reloadTable()
    }
    
    @IBAction private func moreClick() {
        if let onClickMore = onClickMore {
            onClickMore()
        }
    }

}

extension NotiView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notis.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = NotiViewCell.dequeueReuse(tableView: tableView)
        cell.fillData(data: notis[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let onClickNoti = onClickNoti {
//            onClickNoti(notis[indexPath.row].id)
        }
    }
}
