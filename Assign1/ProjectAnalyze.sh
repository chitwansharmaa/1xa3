#!/bin/bash
#Part 1
# Check if Repo is up to date
$(git fetch origin)
localRepo=(git rev-parse master)  #gives an output
remoteRepo=(git rev-parse remote/master)  #gives an output
if [ $localRepo == $remoteRepo ]  #if the outputs are same then the repos are up to date with each other
then
    echo "Local Repo is up to date with Remote Repo"
else
    echo "Local Repo is not up to date with Remote Repo"
fi
#Part 2
#Put all uncommitted changes in a file changes.log
git diff >> changes.log 
read -p "Would you like to view the uncommitted changes? Y/N " ans1
if [ $ans1 == "Y" ]
then
    vim changes.log
else
    echo " The file has been created."
fi

#Part 3
# Puts each line from every file of your project with the tag #TODO into a file todo.log

(grep -r -h "#TODO" --exclude="todo.log" --exclude="ProjectAnalyze.sh" --exclude="changes.log" .) > todo.log
read -p "Would you like to view the file - todo.log? Y/N " ans2
if [ $ans2 == "Y" ]
then 
    vim todo.log
else
    echo "The file has been created."  # grep function searches for PATTERN in each file or standard input
fi

#Part 4
#Check all haskell files for syntax errors and puts the result into error.log
find. -type f -name "*.hs" -exec ghc -fno-code {} \; &> error.log
read -p "Would you like to view the file - error.log ? Y/N " ans3
if [ $ans3 == "Y" ]
then
    vim error.log
else
    echo "The file has been created."
fi 

#Part 5
#Make your own feature
read -p "Let's find how many executable commands are present in the current path."
IFS=":"
count=0 ; nonex=0
for directory in $PATH ;  do
  if [ -d "$directory" ] ; then
    for command in "$directory"/* ; do

       if [ -x "$command" ] ; then
        count="$(( $count + 1 ))"
       else
        nonex="$(( $nonex + 1 ))"
       fi
     done
   fi
done

echo "$count commands, and $nonex entries that weren't executable"
exit 0
         

