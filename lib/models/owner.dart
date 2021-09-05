class Owner {
  Owner({
    this.login,
    this.id,
    this.avatarUrl,
    this.gravatarId,
    this.url,
    this.followersUrl,
    this.followingUrl,
    this.gistsUrl,
    this.type,
    this.siteAdmin,
  });

  String? login;
  int? id;
  String? avatarUrl;
  String? gravatarId;
  String? url;
  String? followersUrl;
  String? followingUrl;
  String? gistsUrl;
  String? type;
  bool? siteAdmin;

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        login: json["login"],
        id: json["id"],
        avatarUrl: json["avatar_url"],
        gravatarId: json["gravatar_id"],
        url: json["url"],
        followersUrl: json["followers_url"],
        followingUrl: json["following_url"],
        gistsUrl: json["gists_url"],
        type: json["type"],
        siteAdmin: json["site_admin"],
      );

  Map<String, dynamic> toJson() => {
        "login": login,
        "id": id,
        "avatar_url": avatarUrl,
        "gravatar_id": gravatarId,
        "url": url,
        "followers_url": followersUrl,
        "following_url": followingUrl,
        "gists_url": gistsUrl,
        "type": type,
        "site_admin": siteAdmin,
      };
}
