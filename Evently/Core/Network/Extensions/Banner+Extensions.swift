//
//  Banner+Extensions.swift
//  Split
//
//  Created by KaayZenn on 06/06/2024.
//

import Foundation

extension Banner {
    struct NetworkError {

        static var badRequestError: Banner {
            return Banner(title: "networkError_400".localized, style: .error)
        }

        static var unauthorizedError: Banner {
            return Banner(title: "networkError_401".localized, style: .error)
        }

        static var notFoundError: Banner {
            return Banner(title: "networkError_404".localized, style: .error)
        }

        static var fieldIsIncorrectlyFilledError: Banner {
            return Banner(title: "networkError_422".localized, style: .error)
        }

        static var internalError: Banner {
            return Banner(title: "networkError_500".localized, style: .error)
        }

        static var parsingError: Banner {
            return Banner(title: "networkError_parsing".localized, style: .error)
        }

        static var refreshTokenFailedError: Banner {
            return Banner(title: "networkError_refreshToken".localized, style: .error)
        }

        static var noConnectionError: Banner {
            return Banner(title: "banner_error_noConnection".localized, style: .error)
        }

        static var unknownError: Banner {
            return Banner(title: "networkError_unknown".localized, style: .error)
        }
    }
}

// MARK: - Register Error
extension Banner {
    static var firstNameError: Banner {
        return Banner(title: "banner_error_firstName".localized, style: .error)
    }

    static var lastNameError: Banner {
        return Banner(title: "banner_error_lastName".localized, style: .error)
    }

    static var userNameError: Banner {
        return Banner(title: "banner_error_userName".localized, style: .error)
    }

    static var emailError: Banner {
        return Banner(title: "banner_error_email".localized, style: .error)
    }

    static var passwordError: Banner {
        return Banner(title: "banner_error_password".localized, style: .error)
    }

    static var confirmPasswordError: Banner {
        return Banner(title: "banner_error_confirmPassword".localized, style: .error)
    }

    static var usernameInvalid: Banner {
        return Banner(title: "banner_422_username_invalid".localized, style: .error)
    }

    static var emailInvalid: Banner {
        return Banner(title: "banner_422_email_invalid".localized, style: .error)
    }
}

// MARK: - Friends
extension Banner {
    static var friendRequestSend: Banner {
        return Banner(title: "banner_success_sendRequest".localized, style: .neutral)
    }

    static var friendRequestRejected: Banner {
        return Banner(title: "banner_friendRequest_rejected".localized, style: .neutral)
    }

    static var friendRequestAccepted: Banner {
        return Banner(title: "banner_friendRequest_accepted".localized, style: .neutral)
    }

    static var friendRequestInvalidUsername: Banner {
        return Banner(title: "banner_friendRequest_invalidUsername".localized, style: .error)
    }
}

// MARK: - Group
extension Banner {
    static var groupAlreadyHere: Banner {
        return Banner(title: "banner_error_group_already_here".localized, style: .error)
    }
    static var groupDeleted: Banner {
        return Banner(title: "banner_error_group_deleted".localized, style: .error)
    }
}

// MARK: - Payment Method
extension Banner {
    static var ibanCopied: Banner {
        return Banner(title: "banner_success_ibanCopied".localized, style: .neutral)
    }
}

// MARK: - Utils
extension Banner {
    static var usernameCopied: Banner {
        return Banner(title: "banner_success_usernameCopied".localized, style: .neutral)
    }

    static var emailCopied: Banner {
        return Banner(title: "banner_success_emailCopied".localized, style: .neutral)
    }
}

extension Banner {
    static let inviteLink: Banner = Banner(
        title: "banner_copy_invite_link".localized, // TODO: TBL
        style: .neutral
    )
}
