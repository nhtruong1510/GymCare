//
//  ChatRoomVC.swift
//  SchoolUp
//
//  Created by Truong Nguyen Huu on 15/02/2023.
//

import UIKit
import SwiftUI

class ChatRoomVC: KUIViewController {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var avatarView: AvatarView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var contentTextField: UITextField!
    @IBOutlet private weak var imageContaintView: UIView!
    
    var idChat: Int?
    var trainer: Trainer?
    private let viewModel = ChatRoomViewModel()
    private var messages: [MessageModel] = []
    private var chatDetail = TopicDetailModel()
    private var timer = Timer()
    private var isLoadDone: Bool = false
    private let total: Int = 10
    private var currentDatetime: Date = Date()

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        getChatDetail(showLoading: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
    }

    deinit {
        timer.invalidate()
    }

    private func setTimer() {
        timer = Timer.scheduledTimer(timeInterval: 5, target: self,
                                         selector: #selector(self.getChatDetail),
                                         userInfo: nil, repeats: true)
    }

    private func configUI() {
        tableView.registerCells(from: .ownerMessageDetailCell, .teacherMessageDetailCell)
        timer.invalidate()
        setTimer()
        avatarView.setupAvatarView(avatar: trainer?.avatar, gender: trainer?.gender)
        titleLabel.text = trainer?.name

    }

    private func reloadData(canScrollBottom: Bool) {
        tableView.reloadData { [weak self] in
            if let `self` = self, self.messages.count > 0, canScrollBottom {
                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
            }
        }
    }
    
    @objc private func getChatDetail(showLoading: Bool) {
        guard let idChat = idChat else { return }
        viewModel.getChatDetail(showLoading: showLoading, id: idChat) { [weak self] data, msg in
            guard let `self` = self else { return }
            if let data = data, let messages = data.messages {
                self.chatDetail = data
                self.messages = messages
                self.reloadData(canScrollBottom: true)
                self.currentDatetime = Date() - 5
            } else {
                AlertVC.show(viewController: self, msg: msg)
            }
        }
    }

    @objc private func getChatDetailReload() {
        let time = currentDatetime.toString(Constants.DATE_TIME_FORMAT)
        viewModel.getReloadChatDetail(id: castToInt(idChat), time: castToString(time)) { [weak self] (data, msg) in
            guard let `self` = self else {return}
            if let messages = data?.messages, messages.count > 0 {
                let indexOfLastCell = self.tableView.indexPathsForVisibleRows?.last
                let numOfMessages = castToInt(self.messages.count)
                self.messages.append(contentsOf: messages)
                self.messages = self.viewModel.filterDupplicateMessages(messages: self.messages)
                self.currentDatetime = Date()
                self.reloadData(canScrollBottom: indexOfLastCell?.row == numOfMessages - 1)
            }
        }
    }

    private func chatMessage() {
        guard let idChat = idChat else { return }
        let insDatetime = castToString(Date().toString(Constants.DATE_TIME_FORMAT_2))
        viewModel.sendChatMessage(id: idChat,
                              content: contentTextField.text!,
                                  ins_datetime: insDatetime) { [weak self] status, msg in
            guard let `self` = self else { return }
            if status {
                self.contentTextField.text = nil
                if self.imageView.image != nil {
                    self.imageView.image = nil
                    self.imageContaintView.isHidden = true
                    self.reloadData(canScrollBottom: true)
                }
//                self.getChatDetail()
            } else {
                AlertVC.show(viewController: self, msg: msg)
            }
        }
    }

    private func viewImageDetail(linkImage: String?) {
//        let popupVC = PreviewViewController()
//        popupVC.previewImage = linkImage
//        self.nextScreen(ctrl: popupVC)
    }
    
    @IBAction private func onClickBackScreen(_ sender: Any) {
        self.backScreen()
    }

    @IBAction private func onClickChooseImage(_ sender: Any) {
        guard let topView = UIApplication.shared.windows.first?.rootViewController else {return}
        ImagePickerManager().pickImage(topView, chooseVideo: false) { [weak self] assets in
            guard let `self` = self, assets.count > 0 else { return }
            let image = assets[0].fullResolutionImage ?? UIImage()
            self.imageView.image = image
            self.imageContaintView.isHidden = false
        }
    }

    @IBAction private func onClickSendMessage(_ sender: Any) {
        if let content = contentTextField.text, content.isEmpty {
            let msg = "Nội dung tin nhắn không được để trống"
            AlertVC.show(viewController: self, msg: msg)
        } else {
            chatMessage()
        }
    }

    @IBAction private func onClickDeleteImage(_ sender: Any) {
        self.imageView.image = nil
        self.imageContaintView.isHidden = true
    }

}

extension ChatRoomVC: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 10))
        view.backgroundColor = .clear
        return view
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = self.messages[indexPath.row]
        if message.isCustomer()  {
            let cell = OwnerMessageDetailCell.dequeueReuse(tableView: tableView)
            cell.fillData(data: message)
            cell.viewImage = { [weak self] in
                guard let `self` = self else { return }
//                self.viewImageDetail(linkImage: message.attachments[0].sourceUrl)
            }
            return cell
        }
        let cell = TeacherMessageDetailCell.dequeueReuse(tableView: tableView)
        cell.fillData(data: message, teacher: trainer)
        cell.viewImage = { [weak self] in
            guard let `self` = self else { return }
//            self.viewImageDetail(linkImage: message.attachments[0].sourceUrl)
        }
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if tableView.contentOffset.y < 20, isLoadDone, castToInt(chatDetail.total) == total {
//            page = page + 1
//            getChatDetail()
//            isLoadDone = false
//        }
    }
}

// 3
struct MyViewControllerRepresentation: UIViewControllerRepresentable {
    // 4
    typealias UIViewControllerType = ChatRoomVC
    
    // 5
    func makeUIViewController(context: Context) -> ChatRoomVC {
        ChatRoomVC()
    }
    
    // 6
    func updateUIViewController(_ uiViewController: ChatRoomVC, context: Context) {
        
    }
}
