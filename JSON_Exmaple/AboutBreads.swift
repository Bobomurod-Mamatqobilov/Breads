//
//  AboutBreads.swift
//  JSON_Exmaple
//
//  Created by Mamatqobilov Bobomurod on 24/07/24.
//

import UIKit
import SnapKit

class AboutBreads: UIViewController{
    
    lazy var tableView: UITableView = {
        let tableview = UITableView()
        tableview.backgroundColor = UIColor.init(red: 17/255, green: 44/255, blue: 9/255, alpha: 0.1)
        tableview.separatorStyle = .none
        
        return tableview
    }()
    let name = UILabel()
    let rank = UILabel()
    let imageView = UIImageView()
//    @IBOutlet weak var imageView: UIImageView!
    let location = UILabel()
//    let locationImg = UIImage()
    let desc = UILabel()
    let type = UILabel()
    let rating = UILabel()
    let flag = UIImageView()
//    @IBOutlet weak var flag: UIImageView!
    
    var arr = [Breads]()
    var index = 0
    var text = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        setUpNav()
        parse()
        //image of bread
        imageView.image = UIImage(named: "fk")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        //name of bread
        name.text = "Name: \(arr[index].name ?? "")"
        name.textColor = .white
        name.translatesAutoresizingMaskIntoConstraints = false
        tableView.addSubview(name)

        //type
        type.text = "Type: \(arr[index].type ?? " ")"
        type.textColor = .white
        type.translatesAutoresizingMaskIntoConstraints = false
        tableView.addSubview(type)
        
        //flag
        flag.image = UIImage(named: "india")
        flag.translatesAutoresizingMaskIntoConstraints = false
        tableView.addSubview(flag)
        
        //location
        location.text = "\(arr[index].loc ?? "")"
        location.textColor = .white
        location.translatesAutoresizingMaskIntoConstraints = false
        tableView.addSubview(location)
        
        //describtion
        desc.text = "Description: \(arr[index].desc ?? "0")"
        desc.numberOfLines = 100
        desc.textColor = .white
        desc.translatesAutoresizingMaskIntoConstraints = false
        tableView.addSubview(desc)
        
        //rank
        rank.text = "Rank: \(arr[index].rank ?? "")"
        rank.textColor = .white
        rank.translatesAutoresizingMaskIntoConstraints = false
        tableView.addSubview(rank)
        
        //rating
        rating.text = "Rating: \(arr[index].rating ?? "")★"
        rating.textColor = .white
        rating.translatesAutoresizingMaskIntoConstraints = false
        tableView.addSubview(rating)
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.bottom.right.equalTo(0)
        }
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: tableView.topAnchor, constant: 5),
            imageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            imageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            name.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            name.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            name.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            name.heightAnchor.constraint(equalToConstant: 20),
            
            type.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 5),
            type.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            type.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            type.heightAnchor.constraint(equalToConstant: 20),
            
            flag.topAnchor.constraint(equalTo: type.bottomAnchor, constant: 5),
            flag.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            flag.rightAnchor.constraint(equalTo: flag.leftAnchor, constant: 20),
            flag.heightAnchor.constraint(equalToConstant: 20),
            
            location.topAnchor.constraint(equalTo: type.bottomAnchor, constant: 5),
            location.leftAnchor.constraint(equalTo: flag.rightAnchor, constant: 10),
            location.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            location.heightAnchor.constraint(equalToConstant: 20),
            
            desc.topAnchor.constraint(equalTo: location.bottomAnchor, constant: 5),
            desc.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            desc.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            desc.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: 0),
            
            rank.topAnchor.constraint(equalTo: desc.bottomAnchor, constant: 5),
            rank.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            rank.rightAnchor.constraint(equalTo: view.centerXAnchor, constant: -10),
            rank.heightAnchor.constraint(equalToConstant: 20),
            
            rating.topAnchor.constraint(equalTo: desc.bottomAnchor, constant: 5),
            rating.leftAnchor.constraint(equalTo: view.centerXAnchor, constant: 10),
            rating.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            rating.heightAnchor.constraint(equalToConstant: 20),
        ])
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
    
    func loadImage(_ url: String) {
        // Ensure the URL is valid
        guard let url = URL(string: url) else {
            print("Invalid URL")
            return
        }
        
        // Fetch the image data
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
            } else {
                print("Failed to load image data")
            }
        }
    }
    func loadImageFlag() {
        // Ensure the URL is valid
        guard let url = URL(string: "https://www.tasteatlas.com/images/emblems/bd8006cea93e43b48958eae34f20106f.png?mh=40") else {
            print("Invalid URL")
            return
        }
        
        // Fetch the image data
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    self.flag.image = UIImage(data: data)
                }
            } else {
                print("Failed to load image data")
            }
        }
    }
    func setUpNav(){
        let titleStr = text
        let font1 = UIFont(name: "Noteworthy Bold", size: 23) ?? .systemFont(ofSize: 23)
        let shadow1 = NSShadow()
        shadow1.shadowColor = UIColor.white
        shadow1.shadowBlurRadius = 1
        
        let atrbutestr: [NSAttributedString.Key : Any] = [.font: font1, .foregroundColor: UIColor.brown, .shadow: shadow1]
        let atributedStr = NSMutableAttributedString(string: titleStr, attributes: atrbutestr)
        
        let titleLabel = UILabel()
        titleLabel.attributedText = atributedStr
        self.navigationItem.titleView = titleLabel
        titleLabel.frame = CGRect(x: 320, y: 120, width: 200, height: 70)
        view.addSubview(titleLabel)
    }
}
