Summary:        GPDB Backup Utility
Name:           gpbackup
Version:        1.20.4
Release:        53
License:        ASL
URL:            https://github.com/greenplum-db/gpbackup+
Source0:        %{name}-%{version}.tar.gz
Group:          User Interface/Desktops
%description
gpbackup and gprestore are Go utilities for performing Greenplum Database backups.
They are still currently in active development.
%prep
%setup -q
%build
make build_linux
%install
make install