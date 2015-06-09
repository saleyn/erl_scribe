-module(scribe_logger).


-export([start/1, start/2, log/3]).

-include("scribe_types.hrl").

%% @doc TCP scribe logger
start(Server, Port) when is_integer(Port) ->
    thrift_client:start_link(Server,
			     Port,
			     scribe_thrift,
			     [{strict_read, false},
			      {strict_write, false},
			      {framed, true}]).

%% @doc UNIX Domain Socket scribe logger
start(Server) when is_list(Server) ->
    thrift_client_util:new(Server,
			     scribe_thrift,
			     [{strict_read, false},
			      {strict_write, false},
			      {framed, true}]).


log(Client, Category,  Message) ->
    thrift_client:call(Client, 'Log',
		       [[#logEntry{category=Category,
				   message=Message}]]),

    ok.
