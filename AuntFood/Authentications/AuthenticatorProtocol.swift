protocol AuthenticatorProtocol {
    static var keychainAccountName: String { get }

    var authenticationHeaderPrefix: String { get }

    var authenticationCredential: String { get }

    var networkType: SocialNetworkType { get }

    func saveCredentialToKeychain()

    var credentialDictionary: [String:String] { get }
}