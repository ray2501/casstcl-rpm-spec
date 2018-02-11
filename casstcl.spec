%{!?directory:%define directory /usr}

%define buildroot %{_tmppath}/%{name}

Name:          casstcl
Summary:       Tcl language interface to the Cassandra database
Version:       2.11
Release:       0
License:       BSD-3 License
Group:         Development/Libraries/Tcl
Source:        https://github.com/flightaware/casstcl/casstcl-2.11.tar.gz
URL:           https://github.com/flightaware/casstcl
BuildRequires: autoconf
BuildRequires: make
BuildRequires: tcl-devel >= 8.5
BuildRequires: cassandra-cpp-driver-devel
Requires:      tcl >= 8.5
Requires:      libcassandra2
BuildRoot:     %{buildroot}

%description
CassTcl provides a Tcl interface to the Cassandra database using the
cpp-driver C/C++ API.

%package devel
Summary:        Development package for CassTcl
Group:          Development/Libraries/Tcl
Requires:       %{name} = %version

%description devel
CassTcl provides a Tcl interface to the Cassandra database using the
cpp-driver C/C++ API.

This package contains development files for CassTcl.

%prep
%setup -q -n %{name}-%{version}

%build
CFLAGS="%optflags"

autoconf
./configure \
	--prefix=%{directory} \
	--exec-prefix=%{directory} \
	--libdir=%{directory}/%{_lib}
make 

%install
make DESTDIR=%{buildroot} pkglibdir=%{tcl_archdir}/%{name}%{version} install

%clean
rm -rf %buildroot

%files
%defattr(-,root,root)
%{tcl_archdir}

%files devel
%defattr(-,root,root)
%{directory}/include/*.h

