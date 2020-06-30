%path.pl
%1. すべてのLとMについて、
%   link(L,M)ならばpath(L,M)である。
path(L,M) :- link(L,M).
%2. すべてのLとMについて、
%   link(L,X)かつpath(X,M)であるXが存在するならばpath(L,M)である。
path(L,M) :- link(L,X), path(X,M).