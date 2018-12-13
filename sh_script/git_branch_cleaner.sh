#!/bin/sh

#this version use array for branch inputs

array=("branch1"
"branch2"
"branch3"
"branch4"
"branch5")

printf "\nNumber of branches: [\e[32m%s\e[0m] \n" "${#array[*]}"

for ix in ${!array[*]}
do
    #git branch -D ${array[$ix]} && git push origin --delete ${array[$ix]}
    if git branch -D ${array[$ix]}; then
        printf "\nBranch \e[32m%s\e[0m was deleted \e[1mlocally\e[0m. \n" "${array[$ix]}"
    else
        printf "\nUnable to delete branch \e[32m%s\e[0m \e[1mlocally\e[0m. \n" "${array[$ix]}"
    fi

    if git push origin --delete ${array[$ix]}; then
        printf "\nBranch \e[32m%s\e[0m was deleted \e[1mremotely\e[0m. \n" "${array[$ix]}"
    else
        printf "\nUnable to delete branch \e[32m%s\e[0m \e[1mremotely\e[0m. \n" "${array[$ix]}"
    fi
done

--------------------------------------------------------------------

# this version use a text file for branch listing
# each branch was separated by newline

file=/path/to/config.txt

while read p; do
    echo $p
    
    git branch -D $p
    printf "Branch \e[32m%s\e[0m was deleted \e[1mlocally\e[0m. \n" ${p}

    git push origin --delete $p
    printf "Branch \e[31m%s\e[0m was deleted \e[1mremotely\e[0m. \n" ${p}
done < $file
