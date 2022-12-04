pad_number () {
    number=$1 # note: how to grab func params
    digits="${number}"

    if [ $number -lt 10 ] # note: spacing `[ cond ]` very important
    then
        digits="0${number}"
    fi

    echo $digits # note: how to return string
}

YEAR="2022"
for index in {1..25}
do
    DAY=$(pad_number $index) #note: how to pass var and grab return value
    NEW_DIR="./${YEAR}-12${DAY}" 
    if [[ -d $NEW_DIR ]]
    then
        echo "directory ${NEW_DIR} exists"
    else
        #mkdir -vp ./2022-1204; # make directory, be verbose, and create intermediary directories if not there
        mkdir -vp $NEW_DIR
        echo "directory ${NEW_DIR} created"
    fi

done

