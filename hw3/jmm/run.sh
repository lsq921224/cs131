#!/bin/sh
javac UnsafeMemory.java
echo "Synchronized"
java UnsafeMemory Synchronized 25 50000 100 10 20 30 40 50
echo "Unsynchronized"
java UnsafeMemory Unsynchronized 25 50000 100 10 20 30 40 50
echo "GetNSet"
java UnsafeMemory GetNSet 25 50000 100 10 20 30 40 50
echo "BetterSafe"
java UnsafeMemory BetterSafe 25 50000 100 10 20 30 40 50
echo "BetterSorry"
java UnsafeMemory BetterSorry 25 50000 100 10 20 30 40 50
rm -rf *.class
