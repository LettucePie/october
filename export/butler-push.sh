 #!/bin/bash

 VER=$(cat "../.git/refs/heads/master")
 echo $VER

butler push ./html lettucepie/rings:html --userversion $VER
