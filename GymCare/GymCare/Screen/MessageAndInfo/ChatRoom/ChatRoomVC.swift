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
    var page: Int = 1
    private let viewModel = ChatRoomViewModel()
    private var messages: [MessageModel] = []
    private var chatDetail = TopicDetailModel()
    private var timer = Timer()
    private var isLoadDone: Bool = false
    private let total: Int = 10

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        getChatDetail()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
    }

    deinit {
        timer.invalidate()
    }

    private func setTimer() {
//        timer = Timer.scheduledTimer(timeInterval: 5, target: self,
//                                         selector: #selector(self.getChatDetailReload),
//                                         userInfo: nil, repeats: true)
    }

    private func configUI() {
        tableView.registerCells(from: .ownerMessageDetailCell, .teacherMessageDetailCell)
        timer.invalidate()
        setTimer()
        avatarView.setupAvatarView(avatar: nil, gender: nil)

    }

    private func reloadData(canScrollBottom: Bool) {
//        tableView.reloadData { [weak self] in
//            if let `self` = self, self.messages.count > 0, canScrollBottom {
//                if self.page <= 1 {
//                    let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
//                    self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
//                } else {
//                    let row = self.messages.count - (self.page-1)*self.total
//                    self.tableView.scrollToRow(at: IndexPath(row: row, section: 0), at: .middle, animated: false)
//                }
//                self.isLoadDone = true
//            }
//        }
    }
    
    private func getChatDetail() {
        guard let idChat = idChat else { return }
//        viewModel.getChatDetail(id: idChat, page: page) { [weak self] data, msg in
//            guard let `self` = self else { return }
//            if let data = data, let messages = data.messages, messages.count > 0 {
//                self.chatDetail = data
//                self.messages.insert(contentsOf: messages.reversed(), at: 0)
//                self.reloadData(canScrollBottom: true)
//            } else {
////                AlertVC.show(msg: msg)
//            }
//        }
    }

    @objc private func getChatDetailReload() {
//        let time = Date().toString(Constants.DATE_TIME_FORMAT)
//        viewModel.getReloadChatDetail(id: castToInt(idChat), time: castToString(time)) { [weak self] (data, msg) in
//            guard let `self` = self else {return}
//            if let messages = data?.messages, messages.count > 0 {
//                let indexOfLastCell = self.tableView.indexPathsForVisibleRows?.last
//                let numOfMessages = castToInt(self.messages.count)
//                self.messages.append(contentsOf: messages.reversed())
//                self.messages = self.viewModel.filterDupplicateMessages(messages: self.messages)
//                self.reloadData(canScrollBottom: indexOfLastCell?.row == numOfMessages - 1)
//            }
//        }
    }

    private func chatMessage() {
        guard let idChat = idChat else { return }
//        viewModel.sendChatMessage(id: idChat,
//                              content: contentTextField.text!,
//                              image: imageView.image) { [weak self] status, msg in
//            guard let `self` = self else { return }
//            if status {
//                self.contentTextField.text = nil
//                if self.imageView.image != nil {
//                    self.imageView.image = nil
//                    self.imageContaintView.isHidden = true
////                    self.reloadData(canScrollBottom: true)
//                }
//            } else {
////                AlertVC.show(msg: msg)
//            }
//        }
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
//        if let content = contentTextField.text, content.isEmpty {
//            let msg = String(format: "%@ validate_required".localized, "comment".localized)
////            AlertVC.show(msg: msg)
//        } else {
//            chatMessage()
//        }
    }

    @IBAction private func onClickDeleteImage(_ sender: Any) {
        self.imageView.image = nil
        self.imageContaintView.isHidden = true
    }

}

extension ChatRoomVC: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2//messages.count
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 10))
        view.backgroundColor = .clear
        return view
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let message = self.messages[indexPath.row]
        if indexPath.row == 0 {//message.isOwner() {
            let cell = OwnerMessageDetailCell.dequeueReuse(tableView: tableView)
//            cell.fillData(data: message)
//            cell.viewImage = { [weak self] in
//                guard let `self` = self else { return }
//                self.viewImageDetail(linkImage: message.attachments[0].sourceUrl)
//            }
            return cell
        }
        let cell = TeacherMessageDetailCell.dequeueReuse(tableView: tableView)
//        cell.fillData(data: message)
//        cell.viewImage = { [weak self] in
//            guard let `self` = self else { return }
//            self.viewImageDetail(linkImage: message.attachments[0].sourceUrl)
//        }
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
