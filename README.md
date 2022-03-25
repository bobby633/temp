# Project.erl
# this project doesnt work but these do

to get the code working  firstly you need to 
#  1#  c(project).
 this initialise the project.erl file making sure everythings all good,
  if it is {ok,project} should appear
# 2#   project:launchNode(Nickname).
 this creates a process with the pid attached to that nickname, the process id is then printed on the screen
 # 3# project:connectNode(NicknameOne,PidOne,NicknameTwo,PidTwo).
* wont work but will connect the pid and nickname together,
* have to manually input the nickname from launchNode in PidOne, eg if the nickname is tom for the process then,
* tom will go in the PidOne part and the same name in " " will be used for the nicknameone eg project:connect("Tom",tom, "jerry", jerry)
# #4 primes() 
will return the primes from 2 , 30'000.
# #5  project:computeNthPrime(N)  
does work returns the value
# #6 Pid ! {rtUpdate,NewRoutingTable}  
it will work if you use the same process otherwise it will clear it 
