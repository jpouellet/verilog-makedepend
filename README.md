# Like [makedepend](https://en.wikipedia.org/wiki/Makedepend), but for Verilog

```
Usage: vmakedep file.[s]v ...
```

## Example:

```
$ vmakedep *_test.sv
add_test.sv: ./myfp.svh ./convert.svh ./normtree.svh
convert_test.sv: ./myfp.svh ./convert.svh
mult_test.sv: ./myfp.svh ./convert.svh ./normtree.svh
```

```
$ make
make: Nothing to be done for 'all'.
$ tail Makefile

depend:
	vmakedep $(VLOG_TARGETS) > Makefile.depend

include Makefile.depend
$ make
make: Nothing to be done for 'all'.
$ touch myfp.svh
$ make
make: Nothing to be done for 'all'.
$ make depend
vmakedep *_test.sv > Makefile.depend
$ touch myfp.svh
$ make
will re-do stuff
```

## Installing

Depends on the preprocessor from [iverilog](http://iverilog.icarus.com/), so install that first.

```
$ make install
```

## TODO:

Add flag to attempt to follow module heirarchies across files when unambiguous instead of just includes.
