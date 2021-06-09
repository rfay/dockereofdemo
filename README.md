This repo is just a test case for Docker Desktop for Mac on Apple M1.

There's a bug in Docker Desktop for Mac where after a few container restarts you get an EOF when hitting a URL in nginx for example. 

https://github.com/docker/for-mac/issues/5407

This repo just demonstrates it. 

This only seems to happen on M1 mac, not amd64, not Windows, etc.

To run this, just check out the repo and `./break.sh`

After a few iterations you'll see

> curl: (52) Empty reply from server