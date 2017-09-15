{ lib, fetchFromGitHub, mediawiki }:

let
  inherit (lib) filter genAttrs;

  bundled = filter (n: n != "out") mediawiki.outputs;

in genAttrs bundled (e: mediawiki.${e}) //
{

  Auth_remoteuser = fetchFromGitHub {
    owner = "wikimedia";
    repo = "mediawiki-extensions-Auth_remoteuser";
    rev = "4efb62f0b61d7270c76d0a87ce21655485dca80a";
    sha256 = "0jy5fj7s8rksiazngr00b0kh5rjb3znir4ghmrh1xv024aw7yrbr";
  };

  EmbedVideo= fetchFromGitHub {
    owner = "HydraWiki";
    repo = "mediawiki-embedvideo";
    rev = "v2.7.0";
    sha256 = "1ddy3w7sqgzmilfks13pj6qx8d4b96nrlg9hfid38iphqq566v9q";
  };

  GraphViz = fetchFromGitHub {
    owner = "wikimedia";
    repo = "mediawiki-extensions-GraphViz";
    rev = "e71433e8475513aa17b244627f1f65826d80b08e";
    sha256 = "0b7kwz89pzv82xgz0gd93q88vn3jhpzk103za0a5h6dbfmmnnbvh";
  };

  MsUpload = fetchFromGitHub {
    owner = "wikimedia";
    repo = "mediawiki-extensions-MsUpload";
    rev = "a77b492a6d9d1b0ea4b098c5ae8b8f652674c7d5";
    sha256 = "0vn0d2c1wmm8bi0jakg9xsimbz1gp0nrrmiwg0lbj9l38nq90al8";
  };

  UserPageEditProtection = fetchFromGitHub {
    owner = "wikimedia";
    repo = "mediawiki-extensions-UserPageEditProtection";
    rev = "2171b3507bf1ef310bc7ad23e31442f5700bb0df";
    sha256 = "1mi57105zl109q3w7nrx9kvi0mw8ynkx5l9z1zq923r08pr62vya";
  };

}
