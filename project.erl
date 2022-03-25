%%%-------------------------------------------------------------------
%%% @author Bobby <bobby@bobby-VirtualBox>
%%% @copyright (C) 2022, Bobby
%%% @doc
%%%
%%% @end
%%% Created : 18 Mar 2022 by Bobby <bobby@bobby-VirtualBox>
%%%-------------------------------------------------------------------
-module(project).
-export([call/2,sendMsg/4,recMsg/0,range/2,remove_multiples/2,sieve/1,primes/0,computeNthPrime/1,launchNode/1, server/2,updateMyTable/2,loop/2,init/0 ]).
%updateMyTable/2,getNeighbour/3,findN/2,server/2,nList/2,set_together/2,updateRt/2,init/0
%list_to_atom


%nList(X,[])->
%    [X];
%nList(X,[Head|Tail]) ->
%    [Head|nList(X,Tail)].

%set_together(List,N)->
    
%    N = nList(N,[List]).
    

   % nList(R,[]).

%

%start(Nickname) ->
%    Pid =spawn(project,recMsg,[]),
    
%    register(Nickname,Pid),
%    R = #{Nickname => Pid},
%    set_together(R).
    

   % routertable(RouterMap).
init()->
    NeighbourList = [],
    RoutingTable =[],
    loop(NeighbourList,RoutingTable).
loop(INL,RT)->	   
 
    UpdatedINL = INL, 
    UpdatedRT ++ RT,
    NewRT = UpdateRT,
    io:fwrite("here is it~p~n",[NewRT]),
  
    
    




    server(UpdatedINL,NewRT).	

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
    end,
    receive
	{ansPrime,Sender2, ME ,M,T} ->
	    	    io:fwrite("~p~p~p~p~p~n ",[ansPrime,Sender2, ME ,M,T]) 
    end,
    receive
	{calcPrime,Sender3,Dest,N2,Hops2} ->
	    io:fwrite("~p~p~p~p~p~n ",[calcPrime,Sender3,Dest ,N2,Hops2])
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




server(NeighbourList,RoutingTable)->
    receive
	{rtUpdate,NewRoutingTable} ->
	    io:fwrite("it did something tf~n"),
	    NewRt = updateMyTable(NewRoutingTable,RoutingTable),
	    if
		NewRt =/= RoutingTable ->
		    updateRt(NeighbourList,NewRt),
		    	    io:fwrite("it did something again ~p tf~n",[NewRt])
	    end,
	    loop(NeighbourList,NewRt),
	    server(NeighbourList,NewRt)
    end.

updateRt([],_)->
    true;
updateRt([{Name,_}|Tail],RT) ->
    Name ! {rtUpdate,RT},
    updateRt(Tail,RT).


updateMyTable(Head,[])->
    [Head];
updateMyTable(X,[Head|Tail]) when X>Head->
    [X,Head|Tail];
updateMyTable(X,[Head|Tail]) ->
    [Head|updateMyTable(X,Tail)].

%    
%server(NeighbourList,RoutingTable)->
%    receive
%	{rtUpdate,_,NewRoutingTable} ->
%	    NewRt = updateMyTable(NewRoutingTable,RouteTable),
%	    if
%		NewRt =/= RouteTable ->
%		    updateRt(NeighbourList,NewRt)
%	    end,
%	    server(NeighbourList,NewRt);
%	{calcPrime,_,_,_,Hops} when Hops >15 ->
%	    server(NeighbourList,RoutingTable);

%	{calcPrime,Sender,Dest,N,_} when Dest == self() ->
%	    Answer = computeNthPrime(N),
%	    Neighbour = getNeighbour(Sender,RouteTable,NeighbourList),
%	    if
%		Neighbour=:=null ->
%		    io:format("~p doesnt exist",[Neighbour])
%	    end;
%		_ ->
%	    Neighbour!{ansPrime,self(),Sender,Answer,0};
%	{calcPrime,Sender,Dest,N,Hops}->
%	    Neighbour = getNeighbour(Dest,RouteTable,NeighbourList),
%	    Neighbour ! {calcPrime,Sender,Dest,N,Hops+1},
%		server(NeighbourList,RouteTable);
	%{addNeighbour, NName,NPid}->
	 %   updateRt([{NName,NPid}|NeighbourList],[{NName,1,NName}|RouteTable]),
	  %  server([{NName,NPid}|NeighbourList],[{NName,1,NName}|RouteTable]);
	   % _ ->
	    %server(NeighbourList,RoutingTable)
%    end.
%
%
%getNeighbour(_,[],_)->
%    null;
%getNeighbour(Name,[{Name,_,Neighbour}| _],NL) ->
%    findN(Neighbour,NL);
%getNeighbour(Name,[_|Tail],NL) ->
%    getNeighbour(Name,Tail,NL).

%findN(_,[])->
%    null;
%findN(Dest,[{Dest,Pid}|_]) ->
%    Pid;
%findN(Dest,[_|Tail]) ->
%    findN(Dest,Tail).



    

%node_Startup(Nickname)->
%    launchNode(Nickname).

launchNode(Nickname)->
        {Nickname, self()}.

%connectNode(NicknameOne,PidOne,NicknameTwo,PidTwo) ->


