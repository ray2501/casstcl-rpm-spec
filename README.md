# casstcl-rpm-spec
openSUSE RPM spec for casstcl

這是一個用來建立 casstcl openSUSE RPM 的 spec。

## C/C++ Driver for Apache Cassandra

[DataStax C/C++ Driver for Apache Cassandra](https://github.com/datastax/cpp-driver) 有提供建立 RedHad RPM 的方法，
執行 packaging 目錄下的 build_rpm.sh 就可以建立需要的 RPM。

如果自己在 openSUSE 的環境 build 一個 RPM 檔案以後再安裝，在安裝 libuv-devel 以後，需要進行下列的修改：

檔案 packaging/build_rpm.sh：

  -libuv_version=$(rpm -q --queryformat "%{VERSION}" libuv)  
  +libuv_version=$(rpm -q --queryformat "%{VERSION}" libuv1)

檔案 packaging/cassandra-cpp-driver.spec，移除掉下列 for redhat 系統的設定：

  -%if %{distnum} == 5  
  -BuildRequires: buildsys-macros >= 5  
  -%endif

再來修改相依性設定：

  -Requires: libuv >= %{libuv_version}  
  +Requires: libuv1 >= %{libuv_version}

如果順利，在 packaging/build/RPMS/x86_64 目錄應該有產生出來的 RPM 檔案：

  sudo rpm -ihv cassandra-cpp-driver-2.5.0-1.x86_64.rpm cassandra-cpp-driver-devel-2.5.0-1.x86_64.rpm

這樣就完成了前置準備。

## casstcl

[casstcl](https://github.com/flightaware/casstcl) 運用 rpm spec，透過 rpmbuild 或者是其它相關的工具建立一個 RPM 檔案以後來安裝。
