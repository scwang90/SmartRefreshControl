//
//  DemoViewController.swift
//  SmartRefreshDemo
//
//  Created by SCWANG on 2021/11/4.
//

import UIKit	

class DemoViewController: UITableViewController {

    
    class Item {
        let name: String
        let type: UIViewController.Type
        init(_ type: UIViewController.Type) {
            self.type = type
            self.name = NSStringFromClass(type)
                .replacingOccurrences(of: "SmartRefreshDemo.UI", with: "")
                .replacingOccurrences(of: "Controller", with: "")
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
    
    let groups: [Group] = [
        Group("Header Style", [
            Item(UIDeliveryController.self),
            Item(UIClassicsController.self),
            Item(UIDropBoxController.self),
            Item(UIPhoenixController.self),
            Item(UITaurusController.self),
            Item(UIBezierRadarController.self),
            Item(UIBezierCircleController.self),
            Item(UIStoreHouseController.self),
            Item(UIWaveSwipeController.self),
            Item(UIOriginalController.self),
            Item(UIMaterialController.self),
            Item(UIGameHitBlockController.self),
            Item(UIGameBattleCityController.self),
            Item(UIFlyController.self),
        ]),
        Group("Footer Style", [
            Item(UIClassicsFooterController.self),
        ])
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

//        self.navigationItem.backButtonTitle
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.groups.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.groups[section].title;
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.groups[section].items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "item", for: indexPath)

        cell.textLabel?.text = self.groups[indexPath.section].items[indexPath.row].name;

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
        let item = self.groups[indexPath.section].items[indexPath.row];
//        self.showDetailViewController(vc, sender: nil);
        if item.name == "Delivery" {
            self.performSegue(withIdentifier: "segue-delivery", sender: nil);
        } else {
            let vc = item.type.init()
            self.navigationController?.pushViewController(vc, animated: true);
        }
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
