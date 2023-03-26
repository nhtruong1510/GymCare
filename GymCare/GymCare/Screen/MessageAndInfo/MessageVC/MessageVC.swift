//
//  MessageVC.swift
//  SchoolUpTeacher
//
//  Created by Nguyen Ha on 09/01/2023.
//

import UIKit

class MessageVC: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = MessageViewModel()
    private var topics: [TopicDetailModel] = []
    private let refreshControl = UIRefreshControl()
    private var isRefresh: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        getTopics()
    }

    private func configUI() {
        tableView.registerCells(from: .messageViewCell)
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }

    @objc private func refresh(_ sender: AnyObject) {
        self.isRefresh = true
        self.viewModel.page = 1
        refreshControl.endRefreshing()
        self.getTopics()
    }

    private func getTopics() {
        viewModel.getTopics() { [weak self] data, msg in
            guard let `self` = self else { return }
            if let data = data {
                self.topics = data.datas
                self.tableView.reloadData()
            } else {
//                AlertVC.show(msg)
            }
        }
    }

}

extension MessageVC: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1//topics.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MessageViewCell.dequeueReuse(tableView: tableView)
//        cell.fillData(data: topics[indexPath.row])
        return cell
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        if maximumOffset - currentOffset <= 10.0 {
            if viewModel.loadMore(topics: self.topics) {
                self.getTopics()
            }
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = ChatRoomVC()
//        vc.idTop = self.topics[indexPath.row].id
        self.nextScreen(ctrl: vc)
    }

}
