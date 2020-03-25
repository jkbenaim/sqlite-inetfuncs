# sqlite-inetfuncs

This is a plugin for SQLite which provides some functions for working with IP addresses. The plugin takes the form of a .dll or .so file depending on your OS.

To use the plugin, first load it into sqlite with the '.load' command: 
```
sqlite> .load ./inetfuncs.dll
```

Then, you can use three new functions:

inet_pton(ip_string) will turn an IP dotted-quad string into its integer representation. Examples:

```
sqlite> select inet_pton('10.5.0.123');
168099963

sqlite> select distinct ip from status order by inet_pton(ip) limit 5;
10.1.1.44
10.1.1.45
10.1.1.50
10.1.2.31
10.2.40.2
```

inet_ntop(ip_d) will turn an IP-as-an-integer back into its dotted-quad notation. It is the complement of 'inet_pton'. Examples:

```
sqlite> select inet_ntop(168099963);
10.5.0.123
sqlite> select inet_ntop(random());
78.168.134.160
```

inet_mask(ip_addr, maskbits) will mask out the lower (32-maskbits) bits of an IP address. The first argument can be either a string or integer IP, and the function will return the same type. Examples:
```
sqlite> select inet_mask('10.246.14.88', 24);
10.246.14.0
sqlite> select ip, inet_mask(ip, 24) from status limit 5;
10.30.54.218|10.30.54.0
10.57.196.200|10.57.196.0
10.58.58.228|10.58.58.0
10.30.152.109|10.30.152.0
10.58.151.105|10.58.151.0
sqlite> select distinct inet_mask(ip,24) || "/24" from status order by inet_pton(ip) limit 5;
10.1.1.0/24            
10.1.255.0/24            
10.2.40.0/24             
10.2.41.0/24             
10.2.43.0/24        
```

<br />
<br />

#### OS X sqlite-inetfuncs install:

The sqlite3 version shipped with OS X does not have the '.load' command enabled. To workaround this, install the latest version of sqlite using brew:

```
brew install sqlite
```

Next, make sure you are using the newly installed Homebrew sqlite and not the OS X installed version (update path or call binary directly):

```
brew --prefix sqlite
/usr/local/opt/sqlite/bin/sqlite3
```

Please note, Gatekeeper will block unverified files/programs from being opened. To workaround this, invoke the following to strip the xattr com.apple.quarantine attribute:

```
xattr -dr com.apple.quarantine inetfuncs.dylib
```

Now to use the plugin, load it into the newly Homebrew installed version of sqlite:

```
/usr/local/opt/sqlite/bin/sqlite3
sqlite> .load inetfuncs.dylib
```
