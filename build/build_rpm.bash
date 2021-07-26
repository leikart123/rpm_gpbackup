#!/bin/bash
tar -cvf gpbackup-1.20.4.tar.bz2 gpbackup;
mv gpbackup-1.20.4.tar.bz2 rpmbuild/SOURCES/;
rpmbuild -ba /home/rpmbuild/rpmbuild/SPECS/gpbackup.spec
Source0:        %{name}-%{version}.tar.gz