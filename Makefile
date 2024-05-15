all: testbin

testbin: main.m
	clang -Wl,-sectcreate,__TEXT,__info_plist,Info.plist -Wl,-sectcreate,__TEXT,__entitlements,org.vodun.push-demo.entitlements -framework Cocoa main.m -o testbin
	codesign -s "551511AFC61032635C565D3FCF855B6BAA5E3062" ./testbin

clean:
	rm -f testbin
