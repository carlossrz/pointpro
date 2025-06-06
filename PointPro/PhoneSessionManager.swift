//
//  WatchConnector.swift
//  PointPro
//
//  Created by Carlos Suarez on 6/6/25.
//

import Foundation
import WatchConnectivity
import SwiftUI

class PhoneSessionManager: NSObject, WCSessionDelegate {
    static let shared = PhoneSessionManager()
    
    override init() {
        super.init()
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
    }
    
    
#if targetEnvironment(simulator)
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        if let data = message["matchData"] as? Data {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            do {
                let codableMatch = try decoder.decode(MatchDataCodable.self, from: data)
                let match = codableMatch.asMatchData()
                print(">>>>>Llego el match: \(match)")
                
                Task {
                  await CRUDDataService.shared.saveMatch(match)
                }
            } catch {
                print("Error decodificando MatchData:", error)
            }
        }
    }
#else
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {

        guard session.activationState == .activated,
              session.isPaired,
              session.isWatchAppInstalled else {
            print("❌ No hay sesión o app del Watch no lista para recibir")
            return
        }

        guard let data = userInfo["matchData"] as? Data else { return }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        do {
            let codableMatch = try decoder.decode(MatchDataCodable.self, from: data)
            let match = codableMatch.asMatchData()
            print(">>>>>Llego el match: \(match)")
            
            Task {
              await CRUDDataService.shared.saveMatch(match)
            }        } catch {
            print("Error decodificando MatchData:", error)
        }

    }
#endif
    
    
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error = error {
            print("❌ Error al activar sesión: \(error.localizedDescription)")
        } else {
            print("✅ Sesión activada en iPhone.")
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("ℹ️ Sesión WCSession inactiva temporalmente")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("🔄 Sesión desactivada, activando nueva sesión...")
        WCSession.default.activate()
    }
}
