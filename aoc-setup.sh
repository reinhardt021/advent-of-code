# // create .gitignore with Session.vim if not already created
# // create README.md at root if not already created

# // take in year form command line argument
# // loop through from the 1st to the 25th
    # // create the folder if not already created
        # // create input_DDa.txt - ex: input_1a.txt
        # // create main_DDa.rb - ex: main_1a.rb
         #// create README_DD.md - ex: README_1.md

# // START: create just a simple method to create the folder for the day

# TODO: create year variable
YEAR="2022"
#mkdir -vp ./2022-1204; # make directory, be verbose, and create intermediary directories if not there
for index in {1..25}
do
    echo "./${YEAR}-12" # TODO: concat index to string

    # TODO: check if folder not created before creating
done

