import Argo
import Runes

struct FacebookInvitableFriend: Decodable {
    let inviteToken: String
    let name: String
    let pictureUrl: String!

    init(inviteToken: String, name: String, pictureUrl: String!) {
        self.inviteToken = inviteToken
        self.name = name
        self.pictureUrl = pictureUrl
    }

    static func create(inviteToken: String)(name: String)(pictureUrl: String?) -> FacebookInvitableFriend {
        return FacebookInvitableFriend(inviteToken: inviteToken, name: name, pictureUrl: pictureUrl)
    }

    static func decode(json: JSON) -> Decoded<FacebookInvitableFriend> {
        return self.create
                <^> json <| "id"
                <*> json <| "name"
                <*> json <|? ["picture", "data", "url"]
    }

    var debugDescription: String {
        get {
            var pUrl = pictureUrl ?? "nil"
            return "Invite token: \(inviteToken)\nName: \(name)\nPictureUrl: \(pUrl)"
        }
    }
}
