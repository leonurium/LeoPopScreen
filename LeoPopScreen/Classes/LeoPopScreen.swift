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
}

public protocol LeoPopScreenDataSource: class {
    var image: UIImage? { get }
    var titleText: String { get }
    var bodyText: String { get }
    var fontTitle: UIFont { get }
    var fontBody: UIFont { get }
    var titleColor: UIColor { get }
    var bodyColor: UIColor { get }
    var buttonPrimaryTextColor: UIColor { get }
    var buttonSecondaryTextColor: UIColor { get }
    var buttonPrimaryColor: UIColor { get }
    var buttonSecondaryColor: UIColor { get }
    var buttonPrimaryText: String { get }
    var buttonSecondaryText: String { get }
    var buttonIsRounded: Bool { get }
    var presentationStyle: UIModalPresentationStyle { get }
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
        let titleText: String
        let bodyText: String
        let buttonPrimaryText: String
    }
    
    public enum ConfigurationType {
        case custom(apparances: Apparance)
        case batteryLevel
        case updateApp
    }
    
    private static func getApparance(type: ConfigurationType) -> Apparance {
        switch type {
        case .batteryLevel:
             return Apparance(
                image: UIImage(named: ""),
                titleText: "batteryLevel",
                bodyText: "batteryLevel",
                buttonPrimaryText: "batteryLevel"
            )
        case .updateApp:
            return Apparance(
                image: UIImage(named: "updateApp"),
                titleText: "updateApp",
                bodyText: "updateApp",
                buttonPrimaryText: "updateApp"
            )
            
        case .custom(apparances: let apparance): return apparance
        }
    }
}

final public class LeoPopScreen: UIViewController {
    
    @IBOutlet weak private var imageview: UIImageView!
    @IBOutlet weak private var lbl_title: UILabel!
    @IBOutlet weak private var lbl_body: UILabel!
    @IBOutlet weak private var btn_primary: UIButton!
    @IBOutlet weak private var btn_secondary: UIButton!
    @IBOutlet weak private var constraintHeightImage: NSLayoutConstraint!
    @IBOutlet weak private var constraintWidthImage: NSLayoutConstraint!
    
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
        let orientationDevice = UIDevice.current.orientation
        let constraintScreen = UIScreen.main.bounds.size
        let size = orientationDevice.isPortrait ? constraintScreen.width : constraintScreen.height
        
        constraintHeightImage.constant = size
        constraintWidthImage.constant = size
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
        }
    }
    
    public func show(on controller: UIViewController?) {
        guard let vc = controller else { return }
        self.modalPresentationStyle = dataSource?.presentationStyle ?? .currentContext
        vc.present(self, animated: true, completion: nil)
    }
    
    @objc private func actionPrimary(_ sender: UIButton) {
        delegate?.didTapPrimaryButton(view: self)
    }
    
    @objc private func actionSecondary(_ sender: UIButton) {
        delegate?.didTapSecondaryButton(view: self)
    }
}
