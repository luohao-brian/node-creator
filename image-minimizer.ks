%post --nochroot --interpreter image-minimizer
%include common-minimizer.ks
%include centos7-minimizer.ks
%end

%post
echo "Not removing python source files"
# We are not removing the py files anymore, to ease debugging and development
# From 3.6 on we've got enough space.
#find /usr -name '*.py' -exec rm -f {} \;
#find /usr -name '*.pyo' -exec rm -f {} \;
%end
