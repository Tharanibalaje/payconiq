function fn() {
  karate.configure('connectTimeout', 5000);
  karate.configure('readTimeout', 5000);
  var config = { demoBaseUrl: 'https://api.github.com' };
    config.token = '39b81eea3d5be1f08eb688344127bc0b165d1183';
    config.authorization = 'Basic dGhhcmFuaWJhbGFqZTozOWI4MWVlYTNkNWJlMWYwOGViNjg4MzQ0MTI3YmMwYjE2NWQxMTgz'
  return config;
}
