#!/usr/bin/tclsh

set arch "x86_64"
set base "casstcl-2.11"
set fileurl "https://github.com/flightaware/casstcl/archive/v2.11.tar.gz"

set var [list wget $fileurl -O $base.tar.gz]
exec >@stdout 2>@stderr {*}$var

if {[file exists build]} {
    file delete -force build
}

file mkdir build/BUILD build/RPMS build/SOURCES build/SPECS build/SRPMS
file copy -force $base.tar.gz build/SOURCES

set buildit [list rpmbuild --target $arch --define "_topdir [pwd]/build" -bb casstcl.spec]
exec >@stdout 2>@stderr {*}$buildit

# Remove our source code
file delete -force $base.tar.gz

