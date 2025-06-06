//
//  ConnectorMobile.swift
//  PointWatch Watch App
//
//  Created by Carlos Suarez on 6/6/25.
//

import WatchConnectivity
import Foundation

class WatchSessionManager: NSObject, WCSessionDelegate {
    
    static let shared = WatchSessionManager()
    
    override init() {
        super.init()
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: (any Error)?) {
        if let error = error {
            print("❌ Activación fallida: \(error.localizedDescription)")
        } else {
            print("✅ Sesión activada con estado: \(activationState.rawValue)")
        }
    }
    
    func sendMessageMatchResult(match: MatchData) {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        do {
            let data = try encoder.encode(match.asCodable())
            let message: [String: Any] = ["matchData": data]
            WCSession.default.sendMessage(message, replyHandler: nil) { error in
                print("Error en sendMessage:", error)
            }
        } catch {
            print("Error codificando MatchData:", error)
        }
    }
    
    func sendMatchResult(match: MatchData) {
        let session = WCSession.default
        
        guard session.activationState == .activated else {
            print("❌ Sesión no activada en Watch")
            return
        }
        
        guard session.isCompanionAppInstalled else {
            print("❌ La app del iPhone no está instalada")
            return
        }
        
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        do {
            let data = try encoder.encode(match.asCodable())
            let info: [String: Any] = [
                "matchData": data,
                "timestamp": Date().timeIntervalSince1970
            ]
            WCSession.default.transferUserInfo(info)
        } catch {
            print("Error codificando MatchData:", error)
        }
    }
    
    func session(_ session: WCSession, didFinish userInfoTransfer: WCSessionUserInfoTransfer, error: Error?) {
        if let error = error {
            print("Transferencia fallida: \(error.localizedDescription)")
        } else {
            print("Datos enviados exitosamente desde el Watch.")
        }
    }
}


