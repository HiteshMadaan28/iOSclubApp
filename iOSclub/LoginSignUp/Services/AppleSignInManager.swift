//
//  AppleSignInManager.swift
//  iOSclub
//
//  Created by Hitesh Madaan on 24/03/25.
//

import AuthenticationServices
import SwiftUI

final class AppleSignInManager: NSObject {
    static let shared = AppleSignInManager()
    private var completion: ((Result<User, Error>) -> Void)?
    
    func signIn(completion: @escaping (Result<User, Error>) -> Void) {
        self.completion = completion
        
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
}

extension AppleSignInManager: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let credentials = authorization.credential as? ASAuthorizationAppleIDCredential else {
            completion?(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid credentials"])))
            return
        }
        
        let user = User(
            id: credentials.user,
            name: credentials.fullName?.givenName ?? "Apple User",
            email: credentials.email ?? "No Email",
            provider: .apple
        )
        completion?(.success(user))
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        completion?(.failure(error))
    }
}

extension AppleSignInManager: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        UIApplication.shared.windows.first { $0.isKeyWindow }!
    }
}
