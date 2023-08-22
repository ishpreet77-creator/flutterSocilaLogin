class googleAuthModel {
  final String? displayName;
  final String? email;
  final bool? isEmailVerified;
  final bool? isAnonymous;
  final Metadata? metadata;
  final String? phoneNumber;
  final String? photoURL;
  final List<Info>? providerData;
  final String? refreshToken;

  googleAuthModel({
    this.displayName,
    this.email,
    this.isEmailVerified,
    this.isAnonymous,
    this.metadata,
    this.phoneNumber,
    this.photoURL,
    this.providerData,
    this.refreshToken,
  });
}

class Metadata {
  final String? creationTime;
  final String? lastSignInTime;

  Metadata({
    this.creationTime,
    this.lastSignInTime,
  });
}

class Info {
  final String? displayName;
  final String? email;
  final String? phoneNumber;
  final String? photoURL;
  final String? providerId;
  final String? uid;

  Info({
    this.displayName,
    this.email,
    this.phoneNumber,
    this.photoURL,
    this.providerId,
    this.uid,
  });

}
