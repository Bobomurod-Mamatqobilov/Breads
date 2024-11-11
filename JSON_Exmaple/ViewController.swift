//
//  ViewController.swift
//  JSON_Exmaple
//
//  Created by Mamatqobilov Bobomurod on 24/07/24.
//

import UIKit
import SnapKit
import SDWebImage

class ViewController: UIViewController {
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.init(red: 17/255, green: 44/255, blue: 9/255, alpha: 0.6)
        tableView.separatorStyle = .singleLine
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    var arr = [Breads]()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
//        83 105 68
        setNav()
        parse()
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.bottom.right.equalTo(0)
        }
        
    }
    func setNav() {
       
        let titleStr = "Breads"
        let font1 = UIFont(name: "Noteworthy Bold", size: 23) ?? .systemFont(ofSize: 23)
        let shadow1 = NSShadow()
        shadow1.shadowColor = UIColor.white
        shadow1.shadowBlurRadius = 2
        
        let titleAttr: [NSAttributedString.Key : Any] = [.font : font1, .foregroundColor: UIColor.orange, .shadow: shadow1]
        let attributedStr = NSMutableAttributedString(string: titleStr, attributes: titleAttr) // NSAttributedString(string: titleStr, attributes: titleAttr)
        
        let titleLabel = UILabel()
        titleLabel.attributedText = attributedStr
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.navigationItem.titleView = titleLabel
        
        let leftImage = UIImage(named: "navLogo")?.withRenderingMode(.alwaysOriginal)
        let leftBarBtn = UIBarButtonItem(image: leftImage, style: .plain, target: self, action: #selector(leftMenuClicked))
        self.navigationItem.leftBarButtonItem = leftBarBtn
        
        titleLabel.frame = CGRect(x: 220, y: 120, width: 200, height: 70)
        view.addSubview(titleLabel)
        
    }
    @objc func leftMenuClicked(_ sender: UIBarButtonItem){
        print("Left tapped!!")
    }

    func parse(){
        guard let path = Bundle.main.path(forResource: "breads", ofType: "json") else {return}
        let url = URL(fileURLWithPath: path)
        if let data = try? Data(contentsOf: url){
            do{
                if let json = try JSONSerialization.jsonObject(with: data) as? [[String: AnyObject]]{
                    for item in json{
                        let obj = Breads.init(item)
                        arr.append(obj)
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
            catch let error as NSError{
                print(error)
            }
        }
    }
}

class Breads{
    var name: String?
    var rank: String?
    var img: String?
    var loc: String?
    var locImg: String?
    var desc: String?
    var type: String?
    var rating: String?
    var flag: String?
    
    init(_ arr: [String: AnyObject]) {
        self.name = arr["name"] as? String
        self.rank = arr["rank"] as? String
        self.img = arr["img"] as? String
        self.loc = arr["loc"] as? String
        self.locImg = arr["locImg"] as? String
        self.desc = arr["desc"] as? String
        self.type = arr["type"] as? String
        self.rating = arr["rating"] as? String
        self.flag = arr["flag"] as? String
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! UITableViewCell
        cell.backgroundColor = .lightGray
        cell.textLabel?.text = "\(arr[indexPath.row].name ?? "")"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("\(indexPath.row) - row")
        let bread = AboutBreads()
        bread.index = indexPath.row
        bread.loadImage(arr[indexPath.row].img ?? "")
        bread.text = arr[indexPath.row].name ?? ""
        navigationController?.pushViewController(bread, animated: true)
    }
    
}
