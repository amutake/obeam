-module(test_wild_attr).

%% test cases for wild attribute
-compile([export_all]).

-vsn('1.0.0').

-on_load(f/0).

-behaviour(gen_server).

-foo(<<"bar">>).

f() -> ok.
