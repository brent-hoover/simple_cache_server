%%%-------------------------------------------------------------------
%%% @author Brent Hoover <brent.hoover@grindr.com>
%%% @copyright (C) 2012, Grindr LLC
%%% @doc simple_cache user API
%%%
%%% @end
%%% Created : 10/3//2012
%%%-------------------------------------------------------------------

-module(simple_cache).

-export([insert/2, lookup/1, delete/1]).

insert(Key, Value) ->
	case sc_store:lookup(Key) of
		{ok, Pid} ->
		sc_element:replace(Pid, Value);
		{error, _} ->
		{ok, Pid} = sc_element:create(Value),
		sc_store:insert(Key, Pid)
	end.

lookup(Key) ->
	try 
		{ok, Pid} = sc_store:lookup(Key),
		{ok, Value} = sc_element:fetch(Pid),
		{ok, Value}
	catch
		_Class:_Exception ->
		{error, not_found}
	end.

delete(Key) ->
	case sc_store:lookup(Key) of
		{ok, Pid} ->
			sc_element:delete(Pid);
		{error, _Reason} ->
		ok
	end.