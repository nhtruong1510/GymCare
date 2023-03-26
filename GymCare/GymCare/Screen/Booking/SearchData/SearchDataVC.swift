//
//  SearchDataVC.swift
//  AppPit
//
//  Created by Nguyễn Hà on 23/08/2022.
//

import UIKit

class SearchDataVC: UIViewController {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!

    var listData: [RegionObject] = []
    var selectedData: RegionObject?
    var titleValue: String?
    var seletedDataCallBack: ((RegionObject) -> (Void))?

    private var listSearchData: [RegionObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }

    private func configUI() {
        titleLabel.text = titleValue
        tableView.registerCells(from: .searchViewCell)
        tableView.tableFooterView = UIView()
        listSearchData = listData
    }

    @IBAction func onClickDismiss(_ sender: Any) {
        self.dismiss(animated: true)
    }

    @IBAction private func editingChanged(_ sender: UITextField) {
        let searchText = castToString(sender.text?.lowercased())
        if searchText.isEmpty {
            listSearchData = listData
        } else {
            listSearchData = listData.filter{
                return castToString($0.name).lowercased().contains(searchText)
            }
        }
        tableView.reloadData()
    }

}

extension SearchDataVC: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listSearchData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SearchViewCell.dequeueReuse(tableView: tableView)
        cell.fillData(data: listSearchData[indexPath.row], seletedData: selectedData)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        seletedDataCallBack?(listSearchData[indexPath.row])
        self.dismiss(animated: true)
    }

}
