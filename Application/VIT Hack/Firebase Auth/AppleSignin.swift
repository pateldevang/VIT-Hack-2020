//
//  AppleSignin.swift
//  VIT Hack
//
//  Created by Aaryan Kothari on 27/07/20.
//  Copyright © 2020 VIT Hack. All rights reserved.
//

import Foundation
import AuthenticationServices
import CryptoKit
import FirebaseAuth

extension HomeViewController : ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding
{
    
    
    @available(iOS 13.0, *)
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        print("presented View")
        return ASPresentationAnchor(frame: view.frame)
    }
    
    
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> =
            Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        print("RESULT:",result)
        return result
    }
    
    
    @available(iOS 13, *)
    func appleSignin() {
        let nonce = randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    @available(iOS 13, *)
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    
    @available(iOS 13.0, *)
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
            
            // Initialize a Firebase credential.
            let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                      idToken: idTokenString,
                                                      rawNonce: nonce)
            
            let fam = appleIDCredential.fullName
            let first = (fam?.givenName ?? "")
            let last = (fam?.familyName ?? "")
            
            let name = first + " " + last
            UserDefaults.standard.set(name, forKey: Keys.name)            // Sign in with Firebase.
            Auth.auth().signIn(with: credential) { (authResult, error) in
                if let error = error {
                    print("AS error:",error.localizedDescription)
                    return
                }
                
                guard let uid = authResult?.user.uid else { return }
                
                UserDefaults.standard.set(uid, forKey: Keys.uid)
                
                print("Sucessfully logged into firebase with Apple!",uid)
                
                UserDefaults.standard.set(authResult?.user.displayName, forKey: Keys.name)
                
                firebaseNetworking.shared.checkUser(uid: uid,completion: self.handleUser(success:))
            }
        }
    }
    
    
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        self.removeBlurView()
        print("ASAuthorizationController: ",error.localizedDescription)
    }
    
    
}

