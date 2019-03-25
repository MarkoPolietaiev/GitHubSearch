//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap(Locale.init) ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)
  
  static func validate() throws {
    try intern.validate()
  }
  
  /// This `R.image` struct is generated, and contains static references to 1 images.
  struct image {
    /// Image `star`.
    static let star = Rswift.ImageResource(bundle: R.hostingBundle, name: "star")
    
    /// `UIImage(named: "star", bundle: ..., traitCollection: ...)`
    static func star(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.star, compatibleWith: traitCollection)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.nib` struct is generated, and contains static references to 1 nibs.
  struct nib {
    /// Nib `RepoItemTableViewCell`.
    static let repoItemTableViewCell = _R.nib._RepoItemTableViewCell()
    
    /// `UINib(name: "RepoItemTableViewCell", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.repoItemTableViewCell) instead")
    static func repoItemTableViewCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.repoItemTableViewCell)
    }
    
    static func repoItemTableViewCell(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> RepoItemTableViewCell? {
      return R.nib.repoItemTableViewCell.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? RepoItemTableViewCell
    }
    
    fileprivate init() {}
  }
  
  /// This `R.reuseIdentifier` struct is generated, and contains static references to 1 reuse identifiers.
  struct reuseIdentifier {
    /// Reuse identifier `RepoItemTableViewCell`.
    static let repoItemTableViewCell: Rswift.ReuseIdentifier<RepoItemTableViewCell> = Rswift.ReuseIdentifier(identifier: "RepoItemTableViewCell")
    
    fileprivate init() {}
  }
  
  /// This `R.storyboard` struct is generated, and contains static references to 2 storyboards.
  struct storyboard {
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    /// Storyboard `Main`.
    static let main = _R.storyboard.main()
    
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    
    /// `UIStoryboard(name: "Main", bundle: ...)`
    static func main(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.main)
    }
    
    fileprivate init() {}
  }
  
  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }
    
    fileprivate init() {}
  }
  
  fileprivate class Class {}
  
  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    try storyboard.validate()
    try nib.validate()
  }
  
  struct nib: Rswift.Validatable {
    static func validate() throws {
      try _RepoItemTableViewCell.validate()
    }
    
    struct _RepoItemTableViewCell: Rswift.NibResourceType, Rswift.ReuseIdentifierType, Rswift.Validatable {
      typealias ReusableType = RepoItemTableViewCell
      
      let bundle = R.hostingBundle
      let identifier = "RepoItemTableViewCell"
      let name = "RepoItemTableViewCell"
      
      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> RepoItemTableViewCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? RepoItemTableViewCell
      }
      
      static func validate() throws {
        if UIKit.UIImage(named: "star", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'star' is used in nib 'RepoItemTableViewCell', but couldn't be loaded.") }
        if #available(iOS 11.0, *) {
        }
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      try launchScreen.validate()
      try main.validate()
    }
    
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController
      
      let bundle = R.hostingBundle
      let name = "LaunchScreen"
      
      static func validate() throws {
        if #available(iOS 11.0, *) {
        }
      }
      
      fileprivate init() {}
    }
    
    struct main: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = StartViewController
      
      let bundle = R.hostingBundle
      let name = "Main"
      let startViewController = StoryboardViewControllerResource<StartViewController>(identifier: "StartViewController")
      
      func startViewController(_: Void = ()) -> StartViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: startViewController)
      }
      
      static func validate() throws {
        if #available(iOS 11.0, *) {
        }
        if _R.storyboard.main().startViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'startViewController' could not be loaded from storyboard 'Main' as 'StartViewController'.") }
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  fileprivate init() {}
}