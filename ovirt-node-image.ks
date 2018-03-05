# centos7 Node image recipe

%include common-install.ks
%include centos7-install.ks

%include repos.ks

%packages --excludedocs --nobase
%include common-pkgs.ks
%include centos7-pkgs.ks

%end

%post
%include common-post.ks
%include centos7-post.ks
%include dracut-post.ks
%end

%post --nochroot
%include common-nochroot.ks

%end

%include image-minimizer.ks
%include common-manifest.ks

