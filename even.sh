echo "enter number:"
read NUMBER

if [ $(($NUMBER %2)) -ne 0 ]; then
    echo "$NUMBER is odd number"
else
    echo "$NUMBER is even number"
fi 