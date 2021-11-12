telnet 127.0.0.1 25
HELO workspace.local
MAIL FROM: me@workspace.local
RCPT TO: you@workspace.local
DATA
Subject: xxxx
xxxx
.


telnet 127.0.0.1 25
HELO workspace.local
MAIL FROM: you@workspace.local
RCPT TO: me@workspace.local
DATA
Subject: xxxx
xxxx
.


telnet 127.0.0.1 25
HELO workspace.local
MAIL FROM: you@gmail.com
RCPT TO: me@workspace.local
DATA
Subject: xxxx
xxxx
.


# wrong TO
telnet 127.0.0.1 25
HELO workspace.local
MAIL FROM: you@workspace.com
RCPT TO: me@gmail.com
DATA
Subject: xxxx
xxxx
.


# RFC 521, 2142
telnet 127.0.0.1 25
HELO workspace.local
MAIL FROM: you@workspace.com
RCPT TO: abuse@workspace.local
DATA
Subject: abuse
abuse
.

telnet 127.0.0.1 25
HELO workspace.local
MAIL FROM: you@workspace.local
RCPT TO: postmaster@workspace.local
DATA
Subject: postmaster
postmaster
.
