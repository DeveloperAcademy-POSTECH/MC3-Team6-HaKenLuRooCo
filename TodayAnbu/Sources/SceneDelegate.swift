//
//  SceneDelegate.swift
//  TodayAnbu
//
//  Created by YeongJin Jeong on 2022/07/14.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        setRootViewController(scene)
        // MARK: 개발 생산성을 위해 엔트리 포인트를 고정하고자 하는 경우 아래의 코드에서 rootViewController를 지정하여 사용
        /*
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        window?.rootViewController = UINavigationController(rootViewController: MemoDetailViewController())
        window?.makeKeyAndVisible()
        */
        // MARK: - 또 다른 스토리보드로 접근하고 싶을 경우
        /*
        let storyboard = UIStoryboard(name: "MemoStoryboard", bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: "MemoViewController") as? MemoViewController {
        window?.rootViewController = UINavigationController(rootViewController: controller)
        window?.makeKeyAndVisible()
        }
         */
    }
    func sceneDidDisconnect(_: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}

extension SceneDelegate {
    private func setRootViewController(_ scene: UIScene) {
        if Storage.goToOnborading {
            setRootViewController(scene, name: "Main", identifier: "RootView")
        } else {
            setRootViewController(scene, name: "Main", identifier: "TabBarView")
        }
    }

    private func setRootViewController(_ scene: UIScene, name: String, identifier: String) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let storyboard = UIStoryboard(name: name, bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: identifier)
            window.rootViewController = viewController
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
