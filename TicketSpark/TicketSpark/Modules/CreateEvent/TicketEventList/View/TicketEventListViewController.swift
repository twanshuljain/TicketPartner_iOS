//
//  TicketEventListViewController.swift
//  TicketSpark
//
//  Created by Apple on 23/02/24.
//

import UIKit

class TicketEventListViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var tbleView: UITableView!
    
    // MARK: - Variables
    var viewModel = TicketEventListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        // Do any additional setup after loading the view.
    }
}
// MARK: - Functions
extension TicketEventListViewController {
    func setTableView() {
        tbleView.register(UINib(nibName: "TicketEventListTableVC", bundle: .main), forCellReuseIdentifier: "TicketEventListTableVC")
        tbleView.dataSource = self
        tbleView.delegate = self
        tbleView.separatorStyle = .none
        tbleView.reloadData()
    }
    @objc func actionOpenMenu(_ sender: UIButton) {
        let vc = BottomSheetViewController(nibName: "BottomSheetViewController", bundle: nil)
        let firstOption = BottomSheetOptionModel(image: UIImage(named: "ic_edit"), option: StringConstants.CreateEvent.edit.value)
        let secondOption = BottomSheetOptionModel(image: UIImage(named: "ic_TrashRed"), option: StringConstants.CreateEvent.delete.value)
        let options = [firstOption, secondOption]
        vc.sheetOptions =  options
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true, completion: nil)
    }
}
// MARK: - UITableViewDataSource, UITableViewDelegate
extension TicketEventListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TicketEventListTableVC", for: indexPath) as! TicketEventListTableVC
        cell.selectionStyle = .none
        cell.stackBtnAddesCodes.isHidden = !(indexPath.last ==  viewModel.numberOfItems - 1)
        cell.btnMenu.tag = indexPath.row
        cell.btnMenu.addTarget(self, action: #selector(self.actionOpenMenu(_ :)), for: .touchUpInside)
        return cell
    }
}
