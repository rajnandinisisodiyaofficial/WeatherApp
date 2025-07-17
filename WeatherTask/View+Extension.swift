//
//  View+Extension.swift
//  WeatherTask
//
//  Created by RajNandini on 15/07/25.
//

import UIKit

extension UIView {
    func addBorder(width: CGFloat = 1.0, color: UIColor = .black, cornerRadius: CGFloat = 0.0) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
    }
    
}


extension UIButton {
    func applyRoundedStyle(
        cornerRadius: CGFloat = 22.5,
        shadowColor: UIColor = .black,
        shadowOpacity: Float = 0.2,
        shadowOffset: CGSize = CGSize(width: 0, height: 2),
        shadowRadius: CGFloat = 4
    ) {
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = false

        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = shadowRadius
    }
}


extension UITableView {
    func registerCell<T: UITableViewCell>(_ type: T.Type) {
        let identifier = String(describing: T.self)
        let nib = UINib(nibName: identifier, bundle: nil)
        self.register(nib, forCellReuseIdentifier: identifier)
    }

    func dequeueCell<T: UITableViewCell>(_ type: T.Type, for indexPath: IndexPath) -> T {
        let identifier = String(describing: T.self)
        guard let cell = self.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T else {
            fatalError("⚠️ Could not dequeue cell with identifier: \(identifier)")
        }
        return cell
    }
}


extension Double {
    var toCelsius: Double {
        return self - 273.15
    }

    var celsiusString: String {
        return String(format: "%.1f°C", self.toCelsius)
    }
}


extension UIView {
    func circular(
        borderwidth: CGFloat = 2.0,
        bordercolor: CGColor = UIColor.lightGray.cgColor){
        self.layer.cornerRadius = (self.frame.size.width / 2.0)
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        self.layer.borderColor = bordercolor
        self.layer.borderWidth = borderwidth
    }
}

extension Date {
    
    /// Returns current date/time as string in given format
    func formatted(_ format: String = "dd MMM yyyy, hh:mm a") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter.string(from: self)
    }

    /// Shortcut to get current formatted date string
    static func currentFormattedDate(_ format: String = "dd MMM yyyy") -> String {
        return Date().formatted(format)
    }
    
    static func currentFormattedTime(_ format: String = "HH:mm") -> String {
        return Date().formatted(format)
    }
}
