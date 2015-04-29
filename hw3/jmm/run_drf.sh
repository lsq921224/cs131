#!/bin/sh
javac BetterSorry.java
javac BetterSafe.java
javac UnsafeMemory.java
echo "Synchronized"
java UnsafeMemory Synchronized 20 10000 100 0 100 0 100 100 0 100 0 100
echo "Unsynchronized"
java UnsafeMemory Unsynchronized 20 10000 100 0 100 0 100 100 0 100 0 100
echo "GetNSet"
java UnsafeMemory GetNSet 20 10000 100 0 100 0 100 100 0 100 0 100
echo "BetterSafe"
java UnsafeMemory BetterSafe 20 10000 100 0 100 0 100 100 0 100 0 100
echo "BetterSorry"
java UnsafeMemory BetterSorry 20 100000 100 0 100 100
rm -rf *.class
