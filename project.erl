%%%-------------------------------------------------------------------
%%% @author Bobby <bobby@bobby-VirtualBox>
%%% @copyright (C) 2022, Bobby
%%% @doc
%%%
%%% @end
%%% Created : 18 Mar 2022 by Bobby <bobby@bobby-VirtualBox>
%%%-------------------------------------------------------------------
-module(project).
-export([start/0,call/2,sendMsg/4,recMsg/0,range/2,remove_multiples/2,sieve/1,primes/0,computeNthPrime/1,launchNode/1,updateMyTable/2,getNeighbour/3,findN/2,updateRt/2,server/2]).



% creates the indivdual process this will be changed to have it be multiple
start() ->
    Pid =spawn(project,recMsg,[]),
    Pid2 =spawn(project,recMsg,[]),
    register(lyle,Pid),
    register(kyle,Pid2).

         
 %will say process is created with PID = 
call(Arg1,Arg2) -> 
  io:fwrite("~p~p~n",[Arg1,Arg2]). 


  



sendMsg( N, DestinationNickname,SenderNickname,Hops)->
    if 
	Hops =< 15 ->
	    DestinationNickname ! {SenderNickname,N,Hops};	    
	true ->
						%Sending message to Destination

	    io:fwrite("too far away ")
	    
    end.


recMsg() ->
    receive
       {Sender,N,Hops} ->
	   
	    io:fwrite("message received from ~p : the prime index is : ~p and hops are ~p~n ",[Sender,N,Hops]) 
    end.










%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    


    
%gets the prime Nth Position
computeNthPrime(0)->
    0;
computeNthPrime(N)->
    lists:nth(N,primes()).







%this makes a list of primes from https://uniwebsidad.com/libros/concurrent-erlang/chapter-3/examples

range(N, N) ->
    [N];
range(Min, Max) ->
    [Min | range(Min+1, Max)].

remove_multiples(N, [H|T]) when H rem N == 0 ->
    remove_multiples(N, T);
remove_multiples(N, [H|T]) ->
    [H | remove_multiples(N, T)];
remove_multiples(_, []) ->
    [].

sieve([H|T]) ->
    [H | sieve(remove_multiples(H, T))];
sieve([]) ->
    [].

primes() ->
     sieve(range(2, 30000)).

updateRt([],_)->
    true;
updateRt([{Name,_}|Tail],RT) ->
    Name ! {updateNNRT,RT},
    updateRt(Tail,RT).


%placeholder needs to actually update
updateMyTable(_,OldRt)->
    OldRt.
    
server(NeighbourList,RoutingTable)->
    receive
	{rtUpdate,SenderPid,NewRoutingTable} ->
	    NewRt = updateMyTable(NewRoutingTable,RouteTable),
	    if
		NewRt =/= RouteTable ->
		    updateRt(NeighbourList,NewRt)
	    end,
	    server(NeighbourList,NewRt);
	{calcPrime,Sender,Dest,N,Hops} when Hops >15 ->
	    server(NeighbourList,RoutingTable);

	{calcPrime,Sender,Dest,N,Hops} when Dest == self() ->
	    Answer = computeNthPrime(N),
	    Neighbour = getNeighbour(Sender,RouteTable,NeighbourList),
	    if
		Neighbour=:=null ->
		    io:format("~p doesnt exist",[Neighbour])
	    end;
		_ ->
	    Neighbour!{ansPrime,self(),Sender,Answer,0};
	{calcPrime,Sender,Dest,N,Hops}->
	    Neighbour = getNeighbour(Dest,RouteTable,NeighbourList),
	    Neighbour ! {calcPrime,Sender,Dest,N,Hops+1},
		server(NeighbourList,RouteTable);
	{addNeighbour, NName,NPid}->
	    updateRt([{NName,NPid}|NeighbourList],[{NName,1,NName}|RouteTable]),
	    server([{NName,NPid}|NeighbourList],[{NName,1,NName}|RouteTable]);
	    _ ->
	    server(NeighbourList,RoutingTable)
    end.


getNeighbour(_,[],_)->
    null;
getNeighbour(Name,[{Name,_,Neighbour}| _],NL) ->
    findN(Neighbour,NL);
getNeighbour(Name,[_|Tail],NL) ->
    getNeighbour(Name,Tail,NL).

findN(_,[])->
    null;
findN(Dest,[{Dest,Pid}|_]) ->
    Pid;
findN(Dest,[_|Tail]) ->
    findN(Dest,Tail).


    

    

%node_Startup(Nickname)->
%    launchNode(Nickname).

launchNode(Nickname)->
        {Nickname, self()}.

%connectNode(NicknameOne,PidOne,NicknameTwo,PidTwo) ->


