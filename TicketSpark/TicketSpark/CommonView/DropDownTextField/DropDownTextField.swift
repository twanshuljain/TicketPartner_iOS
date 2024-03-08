//
//  DropDownTextField.swift
//  Nagad
//
//  Created by Vipin Kumar on 02/09/22.
//

import Foundation
import UIKit

open class DropDownTextField: UITextField {
    
    var arrow: Arrow!
    var table: UITableView!
    var shadow: UIView!
    public var selectedIndex: Int?
    var apiCall: (()->Void)?

    // MARK: IBInspectable
    @IBInspectable public var rowHeight: CGFloat = 50
    @IBInspectable public var rowBackgroundColor: UIColor = .white
    @IBInspectable public var itemsColor: UIColor = .darkGray
    @IBInspectable public var itemsTintColor: UIColor = .blue
    @IBInspectable public var selectedRowColor: UIColor = .systemPink
    @IBInspectable public var hideOptionsWhenSelect: Bool = true
    @IBInspectable public var isSearchEnable: Bool = false {
        didSet {
            addGesture()
        }
    }

//    @IBInspectable public var borderColor: UIColor = UIColor.lightGray {
//        didSet {
//            layer.borderColor = borderColor.cgColor
//        }
//    }

    @IBInspectable public var listHeight: CGFloat = 150 {
        didSet {
            tableheightX = listHeight
        }
    }

//    @IBInspectable public var borderWidth: CGFloat = 0.0 {
//        didSet {
//            layer.borderWidth = borderWidth
//        }
//    }

//    @IBInspectable public var cornerRadius: CGFloat = 5.0 {
//        didSet {
//            layer.cornerRadius = cornerRadius
//        }
//    }
    
    @IBInspectable public var arrowImage: UIImage? {
        didSet {
            arrow.arrowImage = arrowImage
        }
    }

    // Variables
    var completionForSelection : ((UITextField) -> (Void))?
    fileprivate var tableheightX: CGFloat = 100
    fileprivate var dataArray: [String] = []
    fileprivate var imageArray: [String] = []
    fileprivate weak var parentController: UIViewController?
    fileprivate var pointToParent = CGPoint(x: 0, y: 0)
    fileprivate var backgroundView = UIView()
    fileprivate var keyboardHeight: CGFloat = 0
    public var optionArray: [String] = [] {
        didSet {
            dataArray = optionArray
        }
    }

    public var optionImageArray: [String] = [] {
        didSet {
            imageArray = optionImageArray
        }
    }

    var vc: UIViewController?
    public var optionIds: [Int]?
    var searchText = String() {
        didSet {
            if searchText.isEmpty {
                dataArray = optionArray
            } else {
                dataArray = optionArray.filter {
                    searchFilter(text: $0, searchText: searchText)
                }
            }
            reSizeTable()
            selectedIndex = nil
            table.reloadData()
        }
    }

    @IBInspectable public var arrowSize: CGFloat = 15 {
        didSet {
            let center = arrow.superview!.center
            arrow.frame = CGRect(x: center.x - arrowSize / 2, y: center.y - arrowSize / 2, width: arrowSize, height: arrowSize)
        }
    }

    @IBInspectable public var arrowColor: UIColor = .black {
        didSet {
            arrow.arrowColor = arrowColor
        }
    }

    @IBInspectable public var checkMarkEnabled: Bool = true {
        didSet {
        }
    }

    @IBInspectable public var handleKeyboard: Bool = true {
        didSet {
        }
    }

    // Init
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        addPadding()
        delegate = self
    }

    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setupUI()
        addPadding()
        delegate = self
    }
    
    func setDelegate(vc:UIViewController) {
        if  vc is CreatEventVC {
            (vc as! CreatEventVC).delegateApiCall = self
            self.vc = vc
        }
    }

    // MARK: Closures

    fileprivate var didSelectCompletion: (String, Int, Int) -> Void = { _, _, _ in }
    fileprivate var tableWillAppearCompletion: () -> Void = { }
    fileprivate var tableDidAppearCompletion: () -> Void = { }
    fileprivate var tableWillDisappearCompletion: () -> Void = { }
    fileprivate var tableDidDisappearCompletion: () -> Void = { }

    func setupUI() {
        let size = frame.height
        let arrowView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: size, height: size))
        let arrowContainerView = UIView(frame: arrowView.frame)
        if semanticContentAttribute == .forceRightToLeft {
            leftView = arrowView
            leftViewMode = .always
            leftView?.addSubview(arrowContainerView)
        } else {
            rightView = arrowView
            rightViewMode = .always
            rightView?.addSubview(arrowContainerView)
        }

        arrow = Arrow(origin: CGPoint(x: self.frame.width - size, y: center.y/2), size: arrowSize)
        arrowContainerView.addSubview(arrow)
        self.addSubview(arrowContainerView)
        backgroundView = UIView(frame: .zero)
        backgroundView.backgroundColor = .clear
        addGesture()
        if isSearchEnable && handleKeyboard {
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { notification in
                if self.isFirstResponder {
                    let userInfo: NSDictionary = notification.userInfo! as NSDictionary
                    if let keyboardFrame: NSValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                        let keyboardRectangle = keyboardFrame.cgRectValue
                        self.keyboardHeight = keyboardRectangle.height
                        if !self.isSelected {
                            self.showList()
                        }
                    }
                }
            }
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { _ in
                if self.isFirstResponder {
                    self.keyboardHeight = 0
                }
            }
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    fileprivate func addGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(touchAction))
        if isSearchEnable {
            rightView?.addGestureRecognizer(gesture)
        } else {
            addGestureRecognizer(gesture)
        }
        let gesture2 = UITapGestureRecognizer(target: self, action: #selector(touchAction))
        backgroundView.addGestureRecognizer(gesture2)
    }

    func getConvertedPoint(_ targetView: UIView, baseView: UIView?) -> CGPoint {
        var pnt = targetView.frame.origin
        if nil == targetView.superview {
            return pnt
        }
        var superView = targetView.superview
        while superView != baseView {
            pnt = superView!.convert(pnt, to: superView!.superview)
            if nil == superView!.superview {
                break
            } else {
                superView = superView!.superview
            }
        }
        return superView!.convert(pnt, to: baseView)
    }
    private func addPadding() {
       let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    public func showList() {
        if self.vc != nil {
            if self.optionArray.isEmpty {
                self.apiCall?()
            } else {
                self.showData()
            }
        } else {
            self.showData()
        }
    }
    public func showData() {
        
        if parentController == nil {
            parentController = parentViewController
        }
        backgroundView.frame = parentController?.view.frame ?? backgroundView.frame
        pointToParent = getConvertedPoint(self, baseView: parentController?.view)
        parentController?.view.insertSubview(backgroundView, aboveSubview: self)
        tableWillAppearCompletion()
        if listHeight > rowHeight * CGFloat(dataArray.count) {
            tableheightX = rowHeight * CGFloat(dataArray.count)
        } else {
            tableheightX = listHeight
        }
        table = UITableView(frame: CGRect(x: pointToParent.x,
                                          y: pointToParent.y + frame.height,
                                          width: frame.width,
                                          height: frame.height))
        shadow = UIView(frame: table.frame)
        shadow.backgroundColor = .clear
        
        table.dataSource = self
        table.delegate = self
        table.register(UINib(nibName: "DropDownTableViewCell", bundle: nil), forCellReuseIdentifier: "DropDownTableViewCell")
        table.alpha = 0
        table.separatorStyle = .singleLine
        table.layer.cornerRadius = 3
        table.backgroundColor = rowBackgroundColor
        table.rowHeight = rowHeight
        table.showsVerticalScrollIndicator = false
        table.showsHorizontalScrollIndicator = false
        parentController?.view.addSubview(shadow)
        parentController?.view.addSubview(table)
        isSelected = true
        let height = (parentController?.view.frame.height ?? 0) - (pointToParent.y + frame.height + 5)
        var ypoint = pointToParent.y + frame.height + 5
        if height < (keyboardHeight + tableheightX) {
            ypoint = pointToParent.y - tableheightX
        }
        UIView.animate(withDuration: 0.9,
                       delay: 0,
                       usingSpringWithDamping: 0.4,
                       initialSpringVelocity: 0.1,
                       options: .curveEaseInOut,
                       animations: { () -> Void in
            
            self.table.frame = CGRect(x: self.pointToParent.x,
                                      y: ypoint,
                                      width: self.frame.width,
                                      height: self.tableheightX)
            self.table.alpha = 1
            self.shadow.frame = self.table.frame
            //            self.shadow.dropShadow()
            self.arrow.position = .up
            
        },
                       completion: { (_) -> Void in
            self.layoutIfNeeded()
            
        })
    }

    public func hideList() {
        tableWillDisappearCompletion()
        UIView.animate(withDuration: 1.0,
                       delay: 0.4,
                       usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 0.1,
                       options: .curveEaseInOut,
                       animations: { () -> Void in
            self.table.frame = CGRect(x: self.pointToParent.x,
                                      y: self.pointToParent.y + self.frame.height,
                                      width: self.frame.width,
                                      height: 0)
            self.shadow.alpha = 0
            self.shadow.frame = self.table.frame
            self.arrow.position = .down
        },
                       completion: { (_) -> Void in
            
            self.shadow.removeFromSuperview()
            self.table.removeFromSuperview()
            self.backgroundView.removeFromSuperview()
            self.isSelected = false
            self.tableDidDisappearCompletion()
        })
    }

    @objc public func touchAction() {
        if isSelected {
            hideList()
        } else {
            showList()
        }
    }

    func reSizeTable() {
        if listHeight > rowHeight * CGFloat(dataArray.count) {
            tableheightX = rowHeight * CGFloat(dataArray.count)
        } else {
            tableheightX = listHeight
        }
        let height = (parentController?.view.frame.height ?? 0) - (pointToParent.y + frame.height + 5)
        var ypoint = pointToParent.y + frame.height + 5
        if height < (keyboardHeight + tableheightX) {
            ypoint = pointToParent.y - tableheightX
        }
        UIView.animate(withDuration: 0.2,
                       delay: 0.1,
                       usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 0.1,
                       options: .curveEaseInOut,
                       animations: { () -> Void in
            self.table.frame = CGRect(x: self.pointToParent.x,
                                      y: ypoint,
                                      width: self.frame.width,
                                      height: self.tableheightX)
            self.shadow.frame = self.table.frame
//            self.shadow.dropShadow()
            
        },
                       completion: { (_) -> Void in
            //  self.shadow.layer.shadowPath = UIBezierPath(rect: self.table.bounds).cgPath
            self.layoutIfNeeded()
            
        })
    }

    // MARK: Filter Methods

    open func searchFilter(text: String, searchText: String) -> Bool {
        return text.range(of: searchText, options: .caseInsensitive) != nil
    }

    // MARK: Actions Methods

    public func didSelect(completion: @escaping (_ selectedText: String, _ index: Int, _ id: Int) -> Void) {
        didSelectCompletion = completion
    }

    public func listWillAppear(completion: @escaping () -> Void) {
        tableWillAppearCompletion = completion
    }

    public func listDidAppear(completion: @escaping () -> Void) {
        tableDidAppearCompletion = completion
    }

    public func listWillDisappear(completion: @escaping () -> Void) {
        tableWillDisappearCompletion = completion
    }

    public func listDidDisappear(completion: @escaping () -> Void) {
        tableDidDisappearCompletion = completion
    }
}

// MARK: UITextFieldDelegate

extension DropDownTextField: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        superview?.endEditing(true)
        return false
    }

    public func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
        // self.selectedIndex = nil
        dataArray = optionArray
        touchAction()
    }

    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return isSearchEnable
    }

    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty {
            searchText = text! + string
        } else {
            let subText = text?.dropLast()
            searchText = String(subText!)
        }
        if !isSelected {
            showList()
        }
        return true
    }
}

// MARK: UITableViewDataSource

extension DropDownTextField: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "DropDownTableViewCell", for: indexPath) as? DropDownTableViewCell {
            cell.isSelectedCell = indexPath.row == selectedIndex
            cell.bankNameTitleLabel.text = dataArray[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
}

// MARK: UITableViewDelegate

extension DropDownTextField: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = (indexPath as NSIndexPath).row
        let selectedText = dataArray[selectedIndex!]
        tableView.cellForRow(at: indexPath)?.alpha = 0
        tableView.reloadData()
        UIView.animate(withDuration: 0.5,
                       animations: { () -> Void in
                           tableView.cellForRow(at: indexPath)?.alpha = 1.0
                           tableView.cellForRow(at: indexPath)?.backgroundColor = self.selectedRowColor
                       },
                       completion: { (_) -> Void in
                           self.text = "\(selectedText)"
                           self.completionForSelection?(self)
                           tableView.reloadData()
                       })
        if hideOptionsWhenSelect {
            touchAction()
            endEditing(true)
        }
        if let selected = optionArray.firstIndex(where: { $0 == selectedText }) {
            if let id = optionIds?[selected] {
                didSelectCompletion(selectedText, selected, id)
            } else {
                didSelectCompletion(selectedText, selected, 0)
            }
        }
    }
}

// MARK: Arrow

enum Position {
    case left
    case down
    case right
    case up
}

class Arrow: UIView {
    let shapeLayer = CAShapeLayer()
    var arrowColor: UIColor = .black {
        didSet {
          //  shapeLayer.fillColor = arrowColor.cgColor
        }
    }
    
    var arrowImage: UIImage? = UIImage(systemName: "imgDropDown") {
        didSet {
            self.layer.contents = arrowImage?.cgImage
        }
    }

    var position: Position = .down {
        didSet {
            switch position {
            case .left:
                transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)

            case .down:
                transform = CGAffineTransform(rotationAngle: CGFloat.pi * 2)

            case .right:
                transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)

            case .up:
                transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            }
        }
    }

    init(origin: CGPoint, size: CGFloat) {
        super.init(frame: CGRect(x: origin.x, y: origin.y, width: size, height: size))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        layer.contents = arrowImage?.cgImage
        super.draw(rect)
    }
}

extension UIView {
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowRadius = 2
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }

    func viewBorder(borderColor: UIColor, borderWidth: CGFloat?) {
        layer.borderColor = borderColor.cgColor
        if let borderWidth = borderWidth {
            layer.borderWidth = borderWidth
        } else {
            layer.borderWidth = 1.0
        }
    }

    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}

extension DropDownTextField : APICallbackDelegate {
    func apiCallFinished() {
        DispatchQueue.main.async { [self] in
            self.showData()
        }
    }
}
