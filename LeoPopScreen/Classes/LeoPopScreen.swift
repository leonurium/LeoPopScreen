//
//  LeoPopScreen.swift
//  LeoPopScreen
//
//  Created by Rangga Leo on 10/11/20.
//

import UIKit

public protocol LeoPopScreenDelegate: class {
    func didTapPrimaryButton(view: LeoPopScreen)
    func didTapSecondaryButton(view: LeoPopScreen)
    func didCancel(view: LeoPopScreen)
}

public protocol LeoPopScreenDataSource: class {
    var image: UIImage? { get }
    var titleText: String? { get }
    var bodyText: String? { get }
    var fontTitle: UIFont { get }
    var fontBody: UIFont { get }
    var titleColor: UIColor { get }
    var bodyColor: UIColor { get }
    var buttonPrimaryTextColor: UIColor { get }
    var buttonSecondaryTextColor: UIColor { get }
    var buttonPrimaryColor: UIColor { get }
    var buttonSecondaryColor: UIColor { get }
    var buttonPrimaryText: String? { get }
    var buttonSecondaryText: String? { get }
    var buttonIsRounded: Bool { get }
    var presentationStyle: UIModalPresentationStyle { get }
    var showButtonCancelAtNavBar: Bool { get }
    var navBarTitle: Any? { get }
    var navBarBackgroundColor: UIColor { get }
    var navBarForegroundColor: UIColor { get }
}

public extension LeoPopScreenDataSource {
    var fontTitle: UIFont {
        return UIFont.boldSystemFont(ofSize: 24)
    }
    
    var fontBody: UIFont {
        return UIFont.systemFont(ofSize: 20)
    }
    
    var titleColor: UIColor {
        return UIColor.black
    }
    
    var bodyColor: UIColor {
        return UIColor.black
    }
    
    var buttonPrimaryTextColor: UIColor {
        return UIColor.white
    }
    
    var buttonSecondaryTextColor: UIColor {
        return UIColor.white
    }
    
    var buttonPrimaryColor: UIColor {
        return UIColor.blue.withAlphaComponent(0.50)
    }
    
    var buttonSecondaryColor: UIColor {
        return UIColor.gray
    }
    
    var buttonIsRounded: Bool {
        return true
    }
    
    var showButtonCancelAtNavBar: Bool {
        return false
    }
    
    var navBarTitle: Any? {
        return nil
    }
    
    var navBarBackgroundColor: UIColor {
        return UIColor.darkGray
    }
    
    var navBarForegroundColor: UIColor {
        return UIColor.white
    }
}

public struct LeoPopScreenConfiguration {
    let type: ConfigurationType
    var apparances: Apparance
    
    public init(type: ConfigurationType) {
        self.type = type
        self.apparances = LeoPopScreenConfiguration.getApparance(type: type)
    }
    
    public struct Apparance {
        let image: UIImage?
        let titleText: String?
        let bodyText: String?
        let buttonPrimaryText: String?
        let buttonSecondaryText: String?
    }
    
    public enum ConfigurationType {
        case custom(apparances: Apparance)
        case batteryLevelWarning
        case forceUpdateApp
        case relaxUpdateApp
    }
    
    private static func getApparance(type: ConfigurationType) -> Apparance {
        switch type {
        case .batteryLevelWarning:
            return Apparance(
                image: UIImage(identifierName: .image_battery),
                titleText: "Low Battery",
                bodyText: "You need to plug the power adapter into the power outlet to continoue",
                buttonPrimaryText: "OK",
                buttonSecondaryText: nil
            )
        case .forceUpdateApp:
            return Apparance(
                image: UIImage(identifierName: .image_update),
                titleText: "Update Available",
                bodyText: "To use this app, please download the latest version.",
                buttonPrimaryText: "Update",
                buttonSecondaryText: nil
            )
        case .relaxUpdateApp:
            return Apparance(
                image: UIImage(identifierName: .image_update),
                titleText: "Update Available",
                bodyText: "To use this app, please download the latest version.",
                buttonPrimaryText: "Update",
                buttonSecondaryText: "Cancel"
            )
            
        case .custom(apparances: let apparance): return apparance
        }
    }
}

extension LeoPopScreen: LeoPopScreenDataSource {
    public var image: UIImage? {
        return nil
    }
    
    public var titleText: String? {
        return nil
    }
    
    public var bodyText: String? {
        return nil
    }
    
    public var buttonPrimaryText: String? {
        return nil
    }
    
    public var buttonSecondaryText: String? {
        return nil
    }
    
    public var presentationStyle: UIModalPresentationStyle {
        return .currentContext
    }
}

final public class LeoPopScreen: UIViewController {
    
    @IBOutlet weak private var imageview: UIImageView!
    @IBOutlet weak private var lbl_title: UILabel!
    @IBOutlet weak private var lbl_body: UILabel!
    @IBOutlet weak private var btn_primary: UIButton!
    @IBOutlet weak private var btn_secondary: UIButton!
    @IBOutlet weak private var constraintHeightImage: NSLayoutConstraint!
    
    public weak var delegate: LeoPopScreenDelegate?
    public weak var dataSource: LeoPopScreenDataSource?
    private var configuration: LeoPopScreenConfiguration?
    
    public init(on controller: UIViewController? = nil, delegate: LeoPopScreenDelegate? = nil, dataSource: LeoPopScreenDataSource? = nil) {
        super.init(nibName: String(describing: LeoPopScreen.self), bundle: Bundle(for: LeoPopScreen.self))
        self.delegate = delegate
        self.dataSource = dataSource
        show(on: controller)
    }
    
    public init(configuration: LeoPopScreenConfiguration,
         on controller: UIViewController? = nil,
         delegate: LeoPopScreenDelegate? = nil
    ) {
        super.init(nibName: String(describing: LeoPopScreen.self), bundle: Bundle(for: LeoPopScreen.self))
        self.delegate = delegate
        self.dataSource = self
        self.configuration = configuration
        show(on: controller)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        let width = UIScreen.main.bounds.size.width / 2
        constraintHeightImage.constant = width
        imageview.image = dataSource?.image
        lbl_title.text = dataSource?.titleText
        lbl_body.text = dataSource?.bodyText
        lbl_title.textColor = dataSource?.titleColor
        lbl_body.textColor = dataSource?.bodyColor
        btn_primary.setTitle(dataSource?.buttonPrimaryText, for: .normal)
        btn_secondary.setTitle(dataSource?.buttonSecondaryText, for: .normal)
        btn_primary.setTitleColor(dataSource?.buttonPrimaryTextColor, for: .normal)
        btn_secondary.setTitleColor(dataSource?.buttonSecondaryTextColor, for: .normal)
        btn_primary.backgroundColor = dataSource?.buttonPrimaryColor
        btn_secondary.backgroundColor = dataSource?.buttonSecondaryColor
        btn_primary.addTarget(self, action: #selector(actionPrimary(_:)), for: .touchUpInside)
        btn_secondary.addTarget(self, action: #selector(actionSecondary(_:)), for: .touchUpInside)
        btn_primary.layer.shadowColor = UIColor.black.withAlphaComponent(0.25).cgColor
        btn_primary.layer.shadowOffset = CGSize(width: 5, height: 5)
        btn_primary.layer.shadowRadius = 5.0
        btn_primary.layer.shadowOpacity = 30.0
        btn_secondary.layer.shadowColor = UIColor.black.withAlphaComponent(0.25).cgColor
        btn_secondary.layer.shadowOffset = CGSize(width: 5, height: 5)
        btn_secondary.layer.shadowRadius = 5.0
        btn_secondary.layer.shadowOpacity = 30.0
        
        if dataSource?.buttonIsRounded ?? true {
            btn_primary.layer.cornerRadius = btn_primary.frame.size.height / 2
            btn_secondary.layer.cornerRadius = btn_secondary.frame.size.height / 2
        }
        
        if let config = configuration {
            imageview.image = config.apparances.image
            lbl_title.text = config.apparances.titleText
            lbl_body.text = config.apparances.bodyText
            btn_primary.setTitle(config.apparances.buttonPrimaryText, for: .normal)
            btn_secondary.setTitle(config.apparances.buttonSecondaryText, for: .normal)
        }
        hideViewIfNeeded()
        if dataSource?.showButtonCancelAtNavBar ?? false {
            addCancelAtNavigationBar()
        }
    }
    
    private func hideViewIfNeeded() {
        imageview.isHidden = (dataSource?.image == nil && configuration?.apparances.image == nil) ? true : false
        lbl_title.isHidden = (dataSource?.titleText == nil && configuration?.apparances.titleText == nil) ? true : false
        lbl_body.isHidden = (dataSource?.bodyText == nil && configuration?.apparances.bodyText == nil) ? true : false
        btn_primary.isHidden = (dataSource?.buttonPrimaryText == nil && configuration?.apparances.buttonPrimaryText == nil) ? true : false
        btn_secondary.isHidden = (dataSource?.buttonSecondaryText == nil && configuration?.apparances.buttonSecondaryText == nil) ? true : false
    }
    
    private func addCancelAtNavigationBar() {
        if let titleText = dataSource?.navBarTitle as? String {
            navigationItem.title = titleText
        } else if let titleView = dataSource?.navBarTitle as? UIView {
            navigationItem.titleView = titleView
        }
        
        navigationController?.navigationBar.isHidden = !(dataSource?.showButtonCancelAtNavBar ?? true)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : dataSource?.navBarForegroundColor ?? UIColor.white]
        navigationController?.navigationBar.tintColor = dataSource?.navBarForegroundColor
        navigationController?.navigationBar.barTintColor = dataSource?.navBarBackgroundColor
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "cancel", style: .plain, target: self, action: #selector(actionCancel(_:)))
    }
    
    public func show(on controller: UIViewController?) {
        guard let vc = controller else { return }
        self.modalPresentationStyle = dataSource?.presentationStyle ?? .currentContext
        if dataSource?.showButtonCancelAtNavBar ?? false {
            let nav = UINavigationController(rootViewController: self)
            vc.present(nav, animated: true, completion: nil)
        } else {
            vc.present(self, animated: true, completion: nil)
        }
    }
    
    @objc private func actionCancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true) {
            self.delegate?.didCancel(view: self)
        }
    }
    
    @objc private func actionPrimary(_ sender: UIButton) {
        delegate?.didTapPrimaryButton(view: self)
    }
    
    @objc private func actionSecondary(_ sender: UIButton) {
        delegate?.didTapSecondaryButton(view: self)
    }
}


extension UIImage {
    convenience init?(identifierName: Identifier.ImageName) {
        self.init(named: identifierName.rawValue)
    }
}
