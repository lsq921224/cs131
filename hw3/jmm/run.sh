#!/bin/sh
javac UnsafeMemory.java
echo "Synchronized"
java UnsafeMemory Synchronized 32 100000 100 10 20 30 40 50
echo "Unsynchronized"
java UnsafeMemory Unsynchronized 32 100000 100 10 20 30 40 50
echo "GetNSet"
java UnsafeMemory GetNSet 32 100000 100 10 20 30 40 50
echo "BetterSafe"
java UnsafeMemory BetterSafe 32 100000 100 10 20 30 40 50
echo "BetterSorry"
java UnsafeMemory BetterSorry 32 100000 100 10 20 30 40 50
rm -rf *.class
