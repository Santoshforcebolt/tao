//
//  BottomSheetViewController.swift
//  tao
//
//  Created by Mayank Khursija on 14/06/22.
//

import Foundation

class ReportSheetViewController: BaseViewController<ReportSheetViewModel> {
    
    var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
     
    override init(_ viewModel: ReportSheetViewModel) {
        super.init(viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.enableScrollView = false
        super.viewDidLoad()
        self.view.addSubview(self.tableView)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.rowHeight = 60
        
        self.tableView.frame = self.view.bounds
    }
    
    override func reloadView() {
        super.reloadView()
        self.tableView.reloadData()
    }
}

extension ReportSheetViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.sheetItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell()
        cell.textLabel?.text = self.viewModel.sheetItems[indexPath.row]
        cell.textLabel?.textAlignment = .center
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.itemSelected(index: indexPath.row, completion: {
            self.tableView.reloadData()
        })
    }
}
