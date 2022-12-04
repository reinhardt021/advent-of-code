# TODO:CREATE FUNCTION THAT HELPS BUILD TEMPLATES FOR THE WORK
    # TODO: main + input + readme
# // create .gitignore with Session.vim if not already created
# // create README.md at root if not already created

# // take in year form command line argument
# // loop through from the 1st to the 25th
    # // create the folder if not already created
        # // create input_DDa.txt - ex: input_1a.txt
        # // create main_DDa.rb - ex: main_1a.rb
         #// create README_DD.md - ex: README_1.md

# // START: create just a simple method to create the folder for the day
create_file () {
    filename=$1
    touch $filename
    echo "created file: ${filename}"
}

NUM=$1
#echo "got number: " $NUM
create_file "README_${NUM}.md"
create_file "input_${NUM}a.txt"
create_file "input_${NUM}b.txt"
create_file "main_${NUM}a.rb"
#readme_file="README_${NUM}.md"
#touch $readme_file
#echo "created file: ${filename}"
#input_file_a="input_${NUM}a.txt"
#touch $input_file_a
#input_file_b="input_${NUM}b.txt"
#touch $input_file_b
#main_file="main_${NUM}a.rb"
#touch $main_file

#pad_number () {
    #number=$1 # note: how to grab func params
    #digits="${number}"

    #if [ $number -lt 10 ] # note: spacing `[ cond ]` very important
    #then
        #digits="0${number}"
    #fi

    #echo $digits # note: how to return string
#}

#YEAR="2022"
#for index in {1..5}
#for index in {1..25}
#do
    #DAY=$(pad_number $index) #note: how to pass var and grab return value
    #NEW_DIR="./${YEAR}-12${DAY}" 
    #if [[ -d $NEW_DIR ]]
    #then
        #echo "directory ${NEW_DIR} exists"
    #else
        mkdir -vp ./2022-1204; # make directory, be verbose, and create intermediary directories if not there
        #mkdir -vp $NEW_DIR

        #echo "directory ${NEW_DIR} created"
    #fi

#done

