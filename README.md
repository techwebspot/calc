# calc

Just made a simple calc in assembly 32 bit AT&T syntax which helps you to do simple and advance operation which supports floating point numbers. 

Made it to increase my proficency in assemby by making a scipt :p

## Build the executable and execute it

```
as calc.s -o calc.o
ld -dynamic-linker /lib/ld-linux.so.2 calc.o -lc -o calc
./calc
```
