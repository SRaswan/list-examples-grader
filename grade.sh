set -e
CPATH='.:../lib/hamcrest-core-1.3.jar:../lib/junit-4.13.2.jar'

rm -rf student-submission
git clone $1 student-submission
echo 'Finished cloning'

cd student-submission
if [[ -f "ListExamples.java" ]]
then
    echo "ListExamples found"
else
    echo "Error: ListExamples not found"
    exit 1
fi

cp ../TestListExamples.java .

javac -cp $CPATH *.java
if [ $? -ne 0 ]
then
    echo "Error: Compilation Error"
    exit 1
else
    echo "Compiled!"
fi
set +e
java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > temp.txt
grep "Tests run: " temp.txt > temp1.txt
cut -d " " -f 3 temp1.txt > temp2.txt
cut -d "," -f 1 temp2.txt > temp3.txt
cut -d " " -f 6 temp1.txt > temp4.txt
typeset -i a=$(cat temp3.txt)
typeset -i b=$(cat temp4.txt)
declare -i c=$(((a - b) / a))
echo "Grade is: $c"