%% @author Mustafa Paltun <mpaltun@gmail.com>
%% @copyright 2012 mpaltun.
%% @doc istanbus webmachine_resource.

-module(istanbus_web_closest_stops_resource).
-export([init/1, to_json/2, content_types_provided/2]).

-include_lib("webmachine/include/webmachine.hrl").

init([]) ->
    {ok, undefined}.

content_types_provided(ReqData, Context) ->
   {[{"application/json",to_json}], ReqData, Context}.

to_json(ReqData, Context) ->
    Latitude = wrq:path_info(lat, ReqData),
    Longitude = wrq:path_info(long, ReqData),
    
    Result = istanbus_thrift_bridge:get_closest_stops(Latitude, Longitude),
    {mochijson2:encode(Result), ReqData, Context}.