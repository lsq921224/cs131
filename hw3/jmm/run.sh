#!/bin/sh
javac UnsafeMemory.java
echo "Synchronized"
java UnsafeMemory Synchronized 15 50000 100 10 20 30 40 50
echo "Unsynchronized"
java UnsafeMemory Unsynchronized 15 50000 100 10 20 30 40 50
echo "GetNSet"
java UnsafeMemory GetNSet 15 50000 100 10 20 30 40 50
echo "BetterSafe"
java UnsafeMemory BetterSafe 15 50000 100 10 20 30 40 50
echo "BetterSorry"
java UnsafeMemory BetterSorry 15 50000 100 10 20 30 40 50
rm -rf *.class
