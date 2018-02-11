#!/usr/bin/tclsh

set arch "x86_64"
set base "casstcl-2.12_git20170310"

set var2 [list git clone https://github.com/flightaware/casstcl.git $base]
exec >@stdout 2>@stderr {*}$var2

cd casstcl-2.12_git20170310

set var2 [list git checkout 8000abfa8a6d6ad44f7d717991d608679b57bac9]
exec >@stdout 2>@stderr {*}$var2

set var2 [list git reset --hard]
exec >@stdout 2>@stderr {*}$var2

file delete -force .git

cd ..

set var2 [list tar czvf ${base}.tar.gz $base]
exec >@stdout 2>@stderr {*}$var2

if {[file exists build]} {
    file delete -force build
}

file mkdir build/BUILD build/RPMS build/SOURCES build/SPECS build/SRPMS
file copy -force $base.tar.gz build/SOURCES

set buildit [list rpmbuild --target $arch --define "_topdir [pwd]/build" -bb casstcl.spec]
exec >@stdout 2>@stderr {*}$buildit

# Remove our source code
file delete -force $base
file delete -force $base.tar.gz

