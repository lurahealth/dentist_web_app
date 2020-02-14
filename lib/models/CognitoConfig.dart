class CognitoConfig{
  String poolId;
  String clientId;

  CognitoConfig(this.poolId, this.clientId);

  factory CognitoConfig.fromJson(Map<String, dynamic> json){
    return CognitoConfig(
      json["user_pool"],
      json["client"]
    );
  }
}