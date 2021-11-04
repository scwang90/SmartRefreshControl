//
//  DemoTableController.swift
//  Refresh
//
//  Created by SCWANG on 2021/6/20.
//  Copyright © 2021 Teeyun. All rights reserved.
//

import UIKit

class UIDemoHeaderController: UITableViewController {
    
    class Item {
        let name: String
        let detail: String?
        let block: (() -> Void)?
        init(_ name: String, _ detail: String? = nil, _ block: (() -> Void)? = nil) {
            self.name = name;
            self.block = block;
            self.detail = detail;
        }
    }
    
    class Group {
        let title: String
        let items: [Item]
        init(_ title: String, _ items: [Item]) {
            self.title = title;
            self.items = items;
        }
    }
    
    override init(style: UITableView.Style) {
        super.init(style: .grouped)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    var colorAccent: UIColor = UIColor.white
    var colorPrimary: UIColor = UIColor.clear
    var navTranslucent: Bool = true;
    var navTintColor: UIColor = UIColor.black;
    var navBarTintColor: UIColor? = UIColor.white;
    var navBackgroundColor: UIColor? = UIColor.white;
    var navTitleTextAttributes: [NSAttributedString.Key : Any]? = nil
    
    lazy var groups: [Group] = {
        return self.initGroupItems();
    }()
    
    deinit {
        NSLog("deinit-%@", self)
    }
    
    lazy var header: UIRefreshHeader = {
        let header = self.initRefreshHeader();
        self.colorAccent = header.colorAccent;
        self.colorPrimary = header.colorPrimary;
        NSLog("initRefreshHeader-%@", header);
        return header;
    }()
    
    func initRefreshHeader() -> UIRefreshHeader {
        return UIRefreshClassicsHeader.init();
    }
    
    func initGroupItems() -> [Group]{
        NSLog("initGroupItems");
        return [
            Group(" ", [
                Item("默认主题", "点击还原") {[weak self] () in
                    self?.changeTheme(self!.colorPrimary, self!.colorAccent)
                },
                Item("橙色主题", "点击切换") {[weak self] () in
                    self?.changeTheme(UIColor.systemOrange, UIColor.white)
                },
                Item("红色主题", "点击切换") {[weak self] () in
                    self?.changeTheme(UIColor.systemRed, UIColor.white)
                },
                Item("绿色主题", "点击切换") {[weak self] () in
                    self?.changeTheme(UIColor.systemGreen, UIColor.white)
                },
                Item("蓝色主题", "点击切换") {[weak self] () in
                    self?.changeTheme(UIColor.systemBlue, UIColor.white)
                },
            ]),
            Group("测试数据", [
                Item("测试数据1"),
                Item("测试数据2"),
                Item("测试数据3"),
                Item("测试数据4"),
                Item("测试数据5"),
                Item("测试数据6"),
                Item("测试数据7"),
                Item("测试数据8"),
            ])
        ]
    }
    
    func changeTheme(_ primary: UIColor, _ accent: UIColor) {
        self.header.colorAccent = accent;
        self.header.colorPrimary = primary;
        self.header.beginRefresh();
        guard let nav = self.navigationController?.navigationBar else {
            return
        }
        if primary == self.colorPrimary && accent == self.colorAccent {
            nav.isTranslucent = self.navTranslucent
            nav.tintColor = self.navTintColor
            nav.barTintColor = self.navBarTintColor
            nav.backgroundColor = self.navBackgroundColor
            nav.titleTextAttributes = self.navTitleTextAttributes
        } else {
            nav.isTranslucent = false;
            nav.tintColor = accent;
            nav.barTintColor = primary;
            nav.backgroundColor = primary;
            nav.titleTextAttributes = [NSAttributedString.Key.foregroundColor:accent];
        }
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.navigationController?.navigationBar.isTranslucent ?? false ? .default : .lightContent;
    }
    
//    override var childForStatusBarStyle: UIViewController? {
//        return self.top
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = (type(of: self)).description()
            .replacingOccurrences(of: "UI", with: "")
            .replacingOccurrences(of: "SmartRefreshDemo.", with: "")
            .replacingOccurrences(of: "Controller", with: "")

        self.header.attach(self.tableView);
        self.header.addTarget(self, action: #selector(onRefresh), for: .valueChanged)
        self.header.beginRefresh()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        guard let nav = self.navigationController?.navigationBar else {
            return
        }
        self.navTranslucent = nav.isTranslucent;
        self.navTintColor = nav.tintColor;
        self.navBarTintColor = nav.barTintColor;
        self.navBackgroundColor = nav.backgroundColor;
        self.navTitleTextAttributes = nav.titleTextAttributes;
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        guard let nav = self.navigationController?.navigationBar else {
            return
        }
        nav.isTranslucent = self.navTranslucent
        nav.tintColor = self.navTintColor
        nav.barTintColor = self.navBarTintColor
        nav.backgroundColor = self.navBackgroundColor
        nav.titleTextAttributes = self.navTitleTextAttributes
    }
    
    @objc func onRefresh() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            self.header.finishRefresh();
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return groups.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return groups[section].items.count;
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0.001 : 25
//        return super.tableView(tableView, heightForHeaderInSection: section);
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return groups[section].title;
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "item", for: indexPath)

        let cell = tableView.dequeueReusableCell(withIdentifier: "item")
            ?? UITableViewCell.init(style: .value1, reuseIdentifier: "item")

        // Configure the cell...
        cell.textLabel?.text = self.groups[indexPath.section].items[indexPath.row].name;

        cell.detailTextLabel?.text = self.groups[indexPath.section].items[indexPath.row].detail;

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
        self.groups[indexPath.section].items[indexPath.row].block?()
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
