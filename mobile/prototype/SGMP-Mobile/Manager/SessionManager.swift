//
//  SessionManager.swift
//  SGMP-Mobile
//
//  Created by fincher on 10/31/21.
//

import BackgroundTasks
import Foundation
import Defaults
import Alamofire

class SessionManager : BaseManager {
    
    static let instance = SessionManager()
    static let taskIdentifier = "com.JustZht.SGMP-Mobile.refreshToken"
      
    override class var shared: SessionManager {
        return instance
    }
    
    func refreshToken(callback: ((RefreshTokenResponse?, Error?) -> Void)? = nil) {
        NetworkManager.shared.refreshToken { response, err in
            if let err = err {
                print("\(err)")
            } else if let oldUserProfile = Defaults[.userProfile], let newAccessToken = response?.accesstoken {
                Defaults[.userProfile] = .init(user: oldUserProfile, newAccessToken: newAccessToken)
            }
            callback?(response, err)
        }
    }
    
    func logout() {
        Defaults[.userProfile] = nil
    }
    
    override func setup() {
        Defaults.observe(.userProfile) { change in
            DispatchQueue.main.async {
                EnvironmentManager.shared.env.loginRequired = change.newValue == nil
            }
        }.tieToLifetime(of: self)
        
        BGTaskScheduler.shared.register(forTaskWithIdentifier: SessionManager.taskIdentifier,
                                            using: nil) { (task) in
            print("\(SessionManager.taskIdentifier) running")
            if let tokenUpdateDate = Defaults[.userProfile]?.accessTokenUpdatedDate, tokenUpdateDate.timeIntervalSinceNow < -3600 {
                task.expirationHandler = {
                    task.setTaskCompleted(success: false)
                    print("\(SessionManager.taskIdentifier) failed with expirationHandler")
                    Alamofire.Session.default.cancelAllRequests()
                }
                self.refreshToken { res, err in
                    task.setTaskCompleted(success: res != nil)
                    print("\(SessionManager.taskIdentifier) \(res != nil ? "succeeded" : "failed")")
                }
            } else {
                task.setTaskCompleted(success: true)
                print("\(SessionManager.taskIdentifier) token still refresh")
            }
            self.scheduleRefreshTokenTask()
        }
    }
    
    func scheduleRefreshTokenTask () {
        print("scheduleRefreshTokenTask")
        let task = BGAppRefreshTaskRequest(identifier: SessionManager.taskIdentifier)
        task.earliestBeginDate = (Defaults[.userProfile]?.accessTokenUpdatedDate ?? .now).advanced(by: 3600)
        do {
          try BGTaskScheduler.shared.submit(task)
        } catch {
          print("Unable to submit task: \(error.localizedDescription)")
        }
        
    }
    
}
