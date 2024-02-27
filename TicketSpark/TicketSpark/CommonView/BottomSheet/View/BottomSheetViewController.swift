//
//  BottomSheetViewController.swift
//  TicketSpark
//
//  Created by Apple on 26/02/24.
//

import UIKit

class BottomSheetViewController: UIViewController {
    @IBOutlet weak var tbleView: UITableView!
    var sheetOptions: [BottomSheetOptionModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setTapGesture()
    }
    
    func setTableView() {
        tbleView.register(UINib(nibName: "BottomSheetTableViewCell", bundle: .main), forCellReuseIdentifier: "BottomSheetTableViewCell")
        tbleView.dataSource = self
        tbleView.delegate = self
        tbleView.reloadData()
    }
    func setTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.actionTapGesture(_ :)))
        self.view.addGestureRecognizer(tapGesture)
    }
    @objc func actionTapGesture(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true)
    }
}
extension BottomSheetViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sheetOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BottomSheetTableViewCell", for: indexPath) as! BottomSheetTableViewCell
        let data = sheetOptions[indexPath.row]
        cell.imgView.image = data.image
        cell.lbl.text = data.option
        if indexPath.row == sheetOptions.count - 1 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
}
