#!/bin/sh
javac UnsafeMemory.java
echo "Synchronized"
java UnsafeMemory Synchronized 20 10000000 100 10 20 30 40 50
echo "Unsynchronized"
java UnsafeMemory Unsynchronized 20 10000000 100 10 20 30 40 50
echo "GetNSet"
java UnsafeMemory GetNSet 20 10000000 100 10 20 30 40 50
echo "BetterSafe"
java UnsafeMemory BetterSafe 20 10000000 100 10 20 30 40 50
echo "BetterSorry"
java UnsafeMemory BetterSorry 20 10000000 100 10 20 30 40 50
rm -rf *.class
