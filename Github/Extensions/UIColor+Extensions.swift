import UIKit

enum AppColorType: String {
    case AccentColor
    
    case SplashBGColor
    case SplashTextColor
    
    case TitleIconColor
    
    case none
}

enum ColorFetchError: Error {
    case colorNotFound
}

extension UIColor {
    class func color(named name: AppColorType) throws -> UIColor {
        guard let color = UIColor(named: name.rawValue) else {
            throw ColorFetchError.colorNotFound
        }
        return color
    }
}

extension UIColor {
    class var accent: UIColor {
        guard let color = try? color(named: .AccentColor) else {
            fatalError("Cannot find \(AppColorType.AccentColor.rawValue) color name in Assets.xcassets. Make sure the color exists.")
        }
  
        return color
    }
    
    class var splashBackground: UIColor {
        guard let color = try? color(named: .SplashBGColor) else {
            fatalError("Cannot find \(AppColorType.SplashBGColor.rawValue) color name in Assets.xcassets. Make sure the color exists.")
        }
        
        return color
    }
    
    class var titleIcon: UIColor {
        guard let color = try? color(named: .TitleIconColor) else {
            fatalError("Cannot find \(AppColorType.TitleIconColor.rawValue) color name in Assets.xcassets. Make sure the color exists.")
        }
        
        return color
    }
    
    class var splashText: UIColor {
        guard let color = try? color(named: .SplashTextColor) else {
            fatalError("Cannot find \(AppColorType.SplashTextColor.rawValue) color name in Assets.xcassets. Make sure the color exists.")
        }
        
        return color
    }
}
