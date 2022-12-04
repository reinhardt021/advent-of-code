create_file () {
    filename=$1
    touch $filename
    echo "created file: ${filename}"
}

NUM=$1
if [ -z "${NUM}" ] 
then
    echo "ERROR! No number given"
    exit 1
fi
create_file "README_${NUM}.md"
create_file "input_${NUM}a.txt"
create_file "input_${NUM}b.txt"
create_file "main_${NUM}a.rb"
