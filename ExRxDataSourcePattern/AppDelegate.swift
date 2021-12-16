//
//  AppDelegate.swift
//  ExRxDataSourcePattern
//
//  Created by Jake.K on 2021/12/16.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    let singleViewReactor = SingleViewReactor()
    let singleSectionViewController = SingleViewController(reactor: singleViewReactor)
    let navigationController = UINavigationController(rootViewController: singleSectionViewController)
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
    return true
  }

}
