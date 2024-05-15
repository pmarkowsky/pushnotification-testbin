all: testbin

testbin: main.m
	clang -Wl,-sectcreate,__TEXT,__info_plist,Info.plist -Wl,-sectcreate,__TEXT,__entitlements,org.vodun.push-demo.entitlements -framework Cocoa main.m -o testbin
	codesign -s $CODESIGN_HASH ./testbin

clean:
	rm -f testbin
