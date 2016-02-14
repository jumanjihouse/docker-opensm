OpenSM Infiniband Subnet Manager
================================


Build locally
-------------

On a host with Docker:

    docker build --rm -t opensm src/


Run
---

On a host with Docker:

    docker run -d \
      --name opensm.service
      --read-only \
      --memory=10G \
      --privileged \
      --net=host \
      -v /lib/modules:/lib/modules:ro \
      jumanjiman/opensm


Test
----

Run the test harness:

    bats test/*.bats

The test harness uses [BATS](https://github.com/sstephenson/bats).
Output resembles:

    1..6
    ok 1 LICENSE file exists
    ok 2 image exists
    ok 3 image contains opensm package
    ok 4 RDMA config allows IPoIB
    ok 5 RDMA config does not load iSCSI over RDMA
    ok 6 sminfo poll interval is 5 seconds

:warning: I need to figure out how to run acceptance tests
on a host without infiniband devices (such as CircleCI).
On a host with IB, `docker logs <cid>` could show output
similar to [`test/opensm.log`](test/opensm.log), which was
obtained on an unconfigured, tiny test fabric.


License
-------

See [LICENSE](LICENSE).
