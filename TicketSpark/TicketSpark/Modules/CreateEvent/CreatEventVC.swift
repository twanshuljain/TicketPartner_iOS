//
//  CreatEventVC.swift
//  TicketSpark
//
//  Created by Apple on 12/02/24.
//

import UIKit

class CreatEventVC: UIViewController {
    @IBOutlet weak var txtEventTitle: CustomTextFieldView!
    @IBOutlet weak var imgViewAdd1: UIImageView!
    @IBOutlet weak var imgViewAdd2: UIImageView!
    @IBOutlet weak var imgViewAdd3: UIImageView!
    @IBOutlet weak var imgViewAdd4: UIImageView!
    @IBOutlet weak var txtEvntType: DropDownTextField!
    @IBOutlet weak var txtEvntCategories: DropDownTextField!
    @IBOutlet weak var eventDescribeView: UITextView!
    @IBOutlet weak var lblEventTitle: UILabel!
    @IBOutlet weak var lblEventType: UILabel!
    @IBOutlet weak var lblEventCategories: UILabel!
    @IBOutlet weak var lblDescribeEvent: UILabel!
    @IBOutlet weak var lblEventStartDate: UILabel!
    @IBOutlet weak var lblDoorOpenAt: UILabel!
    @IBOutlet weak var lblVenueType: UILabel!
    @IBOutlet weak var lblVenueName: UILabel!
    @IBOutlet weak var txtStartDate: FloatingTextField!
    @IBOutlet weak var txtStartTime: FloatingTextField!
    @IBOutlet weak var txtEndDate: FloatingTextField!
    @IBOutlet weak var txtEndTime: FloatingTextField!
    @IBOutlet weak var txtDoorStartDate: FloatingTextField!
    @IBOutlet weak var txtDoorStartTime: FloatingTextField!
    @IBOutlet weak var txtDoorEndDate: FloatingTextField!
    @IBOutlet weak var txtDoorEndTime: FloatingTextField!
    @IBOutlet weak var txtVenueType: DropDownTextField!
    @IBOutlet weak var txtVenue: CustomTextFieldView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
     
    func setUI() {
        let txtBorder = [txtEventTitle, txtEvntType, txtEvntCategories, eventDescribeView, txtStartDate, txtStartTime, txtEndDate, txtEndTime, txtDoorStartDate, txtDoorStartTime,txtDoorEndDate, txtDoorEndTime]
        for txtBorder in txtBorder {
            txtBorder?.setTextFiledBorder()
        }
        
    }

}
