all: testbin

testbin: main.m
	clang -Wl,-sectcreate,__TEXT,__info_plist,Info.plist -framework Cocoa main.m -o testbin
	codesign -s $(CODESIGN_ID) --entitlements org.vodun.push-demo.entitlements ./testbin

clean:
	rm -f testbin
