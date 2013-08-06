#
# spec file for package yast-rake-tasks
#
# Copyright (c) 2013 SUSE LINUX Products GmbH, Nuernberg, Germany.
#
# All modifications and additions to the file contributed by third parties
# remain the property of their copyright owners, unless otherwise agreed
# upon. The license for this file, and modifications and additions to the
# file, is the same license as for the pristine package itself (unless the
# license for the pristine package is not an Open Source License, in which
# case the license is the MIT License). An "Open Source License" is a
# license that conforms to the Open Source Definition (Version 1.9)
# published by the Open Source Initiative.

# Please submit bugfixes or comments via http://bugs.opensuse.org/
#

######################################################################
#
# IMPORTANT: Please do not change spec file in build service directly
#            Use https://github.com/yast/yast-rake-tasks repo
#
######################################################################

Name:           rubygem-yast-rake-tasks
Version:        0.0.1
Release:        0
BuildArch:      noarch

BuildRoot:      %{_tmppath}/%{name}-%{version}-build
Source0:        yast-rake-tasks.tar.bz2

Requires:       rubygem-rake
BuildRequires:  rubygem-rake

Summary:        YaST Rake tasks
Group:          System/YaST
License:        GPL-2.0

Url:            https://github.com/yast/yast-rake-tasks

%description
Collection of rake tasks for Yast

%prep
%build
%install
%clean
rm -rf "$RPM_BUILD_ROOT"

%files
%defattr(-,root,root)
%{_prefix}/share/YaST2/clients/*.rb
%{_prefix}/share/YaST2/modules/*.rb
%{_prefix}/share/applications/YaST2/services-manager.desktop
%{_prefix}/share/YaST2/schema/autoyast/rnc/*.rnc

%changelog

