with import <nixpkgs> {}; # bring all of Nixpkgs into scope

pythonPackages.buildPythonPackage rec {
  name = "rawdog";
  src = fetchurl {
    url = "http://offog.org/files/rawdog-2.20.tar.gz";
    sha256 = "0a63b26cc111b0deca441f498177b49be0330760c5c0e24584cdb9ba1e7fd5a6";
  };

   propagatedBuildInputs = with pythonPackages; [ feedparser ];
  
}
