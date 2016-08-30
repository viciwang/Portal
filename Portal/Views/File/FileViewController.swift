//
//  FileViewController.swift
//  Portal
//
//  Created by Allen on 8/23/16.
//  Copyright © 2016 Allen. All rights reserved.
//

import UIKit
import SnapKit

class FileViewController: ViewController, UITableViewDelegate, UITableViewDataSource {
    
    let cellIdentifier = "cellIdentifier"
    
    var viewModel: FileViewModel
    let tableView = UITableView(frame: CGRectZero, style: .Plain)
    
    required init(viewModel: ViewModel) {
        self.viewModel = viewModel as! FileViewModel
        super.init(viewModel: viewModel)
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindSignal()
        setupUI()
        self.tableView.reloadData()
    }
    
    override func updateViewConstraints() {
        tableView.snp_remakeConstraints { [unowned self] (make) in
            make.edges.equalTo(self.view)
        }
        super.updateViewConstraints()
    }
    
    //MARK: signal
    func bindSignal() {
        
    }
    
    //MARK: UI
    func setupUI() {
        self.view.addSubview(tableView)
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        self.tableView.setNeedsUpdateConstraints()
        let curveView = CurveView()
        self.view.addSubview(curveView)
        curveView.snp_remakeConstraints { [unowned self] (make) in
            make.edges.equalTo(self.view)
        }
    }
    
    //MARK: tableView delegate and dataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let subFiles = viewModel.subFiles {
            return subFiles.count
        }
        else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        cell.selectionStyle = .None
        if let file = viewModel.subFiles?[indexPath.row]  {
            cell.textLabel?.text = file.displayName
            cell.detailTextLabel?.text = file.displaySize
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.viewModel.selectFileAtIndex(indexPath.row)
    }
}
