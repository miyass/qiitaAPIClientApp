//
//  ViewController.swift
//  qiitaAPIClientApp
//
//  Created by 宮倉宗平 on 2018/09/22.
//  Copyright © 2018年 Sohei Miyakura. All rights reserved.
//

import UIKit
import Dispatch

class ViewController: UIViewController, UITableViewDataSource {
    
    var postTitle: [String] = []
    var postUserName: [String] = []
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.dataSource = self
        let nib = UINib(nibName: "QiitaInfoTableViewCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "cell")
        
        getPosts()
        print(postTitle)
        print(postUserName)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! QiitaInfoTableViewCell
        
        cell.titleLabel.text! = postTitle[indexPath.row]
        cell.nameLabel.text! = postUserName[indexPath.row]
        
        return cell
    }

    func getPosts() {
        let url = URL(string: "https://qiita.com/api/v2/items?page=1&per_page=20&query=swift")!
        let semaphore = DispatchSemaphore(value: 0)
        let task = URLSession.shared.dataTask(with: url) { (data,response,error) in
            if error != nil {
                print(error!)
                return
            }
            do {
                let postsJson = try JSONSerialization.jsonObject(with: data!) as AnyObject
                for postJson in postsJson as! [AnyObject] {
                    let user = postJson["user"] as AnyObject
                    let name = user["name"] as! String
                    let title = postJson["title"] as! String
                    self.postUserName.append(name)
                    self.postTitle.append(title)
                }
                semaphore.signal()
            } catch let error {
                print(error)
            }
        }
        task.resume()
        semaphore.wait()
    }
}

