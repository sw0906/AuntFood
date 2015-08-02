import SSKeychain

struct EmailAuthenticator: AuthenticatorProtocol, DebugPrintable {
    static var keychainAccountName: String {
        get {
            return "TradeHeroEmailKeychainIdentifier"
        }
    }

    private var _cred: String!
    private var email: String!
    private var password: String!

    internal var authenticationHeaderPrefix: String {
        return "Basic"
    }

    var authenticationCredential: String {
        get {
            return "\(authenticationHeaderPrefix) \(_cred)"
        }
    }

    init(email: String, password: String) {
        _cred = "\(email):\(password)".encodeToBase64Encoding()
        self.email = email
        self.password = password
    }

    init?(encodedCredentials: String) {
        _cred = encodedCredentials
        var decodedComponents = encodedCredentials.decodeFromBase64Encoding().componentsSeparatedByString(":")
        if decodedComponents.count == 2 {
            log.error("Decoded components must have 2 items!!")
            return nil
        }

        self.email = decodedComponents[0]
        self.password = decodedComponents[1]
    }

    var debugDescription: String {
        return "< EmailAuthenticator - \(authenticationCredential)) >"
    }

    var networkType: SocialNetworkType {
        return .Unknown
    }

    func saveCredentialToKeychain() {
        SSKeychain.setPassword(_cred, forService: kKeychainIdentifierKey, account: EmailAuthenticator.keychainAccountName)
    }

    var credentialDictionary: [String:String] {
        return ["email": self.email, "password": self.password]
    }
}
