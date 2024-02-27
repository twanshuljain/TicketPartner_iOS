//
//  CreateEventStepper.swift
//  TicketSpark
//
//  Created by Apple on 19/02/24.
//

import UIKit
enum SelectedNumber {
    case first
    case second
    case third
}
class CreateEventStepper: UIView {
    @IBOutlet weak var viewFirst: UIView!
    @IBOutlet weak var viewSecond: UIView!
    @IBOutlet weak var viewThird: UIView!
    @IBOutlet weak var lblFirst: UILabel!
    @IBOutlet weak var lblSecond: UILabel!
    @IBOutlet weak var lblThird: UILabel!
    @IBOutlet weak var lblBasicDetails: UILabel!
    @IBOutlet weak var lblTickets: UILabel!
    @IBOutlet weak var lblEventSetup: UILabel!
    
    @IBOutlet weak var lblSepartorFirst: UILabel!
    @IBOutlet weak var lblSepartorSecond: UILabel!
    
    let nibName = "CreateEventStepper"
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            commonInit()
        }
        override init(frame: CGRect) {
            super.init(frame: frame)
            commonInit()
        }
        func commonInit() {
            guard let view = loadViewFromNib() else { return }
            view.frame = self.bounds
            self.addSubview(view)
            self.setUI()
        }
        func loadViewFromNib() -> UIView? {
            let nib = UINib(nibName: nibName, bundle: nil)
            return nib.instantiate(withOwner: self, options: nil).first as? UIView
        }
    
    func setUI() {
        let views = [viewFirst, viewSecond, viewThird]
        for view in views {
            view?.layer.cornerRadius = viewFirst.frame.height/2
            view?.layer.borderWidth = 1
            view?.layer.borderColor = UIColor.grayTextColor.cgColor
        }
        let lbls = [lblFirst, lblSecond, lblThird, lblBasicDetails, lblTickets, lblEventSetup]
        for lbl in lbls {
            lbl?.textColor = .grayTextColor
            lbl?.font = CustomFont.shared.bold(sizeOfFont: 12)
        }
        lblSepartorFirst.createDottedLine(width: 2, color: UIColor.grayTextColor.cgColor, dashPattern: [5,3], adjustFrameWidth: 100)
        lblSepartorSecond.createDottedLine(width: 2, color: UIColor.grayTextColor.cgColor, dashPattern: [5,3], adjustFrameWidth: 100)
        lblSepartorFirst.createDottedLine(width: 2, color: UIColor.appIndigoSelectedColor.cgColor, dashPattern: [5,3], adjustFrameWidth: 100)
        lblFirst.textColor = .white
        viewFirst.backgroundColor = .appIndigoSelectedColor
        lblBasicDetails.textColor = .appIndigoSelectedColor
        setSelection(selectedAt: .first)
    }
    
    
    func setSelection(selectedAt: SelectedNumber = .first) {
        switch selectedAt {
        case .first:
            lblSepartorFirst.createDottedLine(width: 2, color: UIColor.appIndigoSelectedColor.cgColor, dashPattern: [5,3], adjustFrameWidth: 100)
            lblFirst.textColor = .white
            viewFirst.backgroundColor = .appIndigoSelectedColor
            lblBasicDetails.textColor = .appIndigoSelectedColor
        case .second:
            lblBasicDetails.textColor = .appIndigoSelectedColor
            viewSecond.backgroundColor = .appIndigoSelectedColor
            lblSecond.textColor = .white
            lblTickets.textColor = .appIndigoSelectedColor
        case .third:
            print("third")
        }
    }
}
