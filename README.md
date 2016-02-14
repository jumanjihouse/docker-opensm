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


Diagnostic utilities
--------------------

The image contains the infiniband-diags package.
You can run the tools in two ways:

* Enter a running opensm container via `docker exec -it <cid> bash`
  and call the utils directly.

* Start a fresh container with something like:

  ```
  docker run --rm -it --net=host --privileged --entrypoint bash jumanjiman/opensm
  ```

Sample output from `ibnetdiscover` (one of the utils) is shown at
[`test/ibnetdiscover.out`](test/ibnetdiscover.out).


Test
----

Run the test harness:

    bats test/*.bats

The test harness uses [BATS](https://github.com/sstephenson/bats).
Output resembles:

    1..8
    ok 1 LICENSE file exists
    ok 2 image exists
    ok 3 image contains opensm package
    ok 4 RDMA config allows IPoIB
    ok 5 RDMA config does not load iSCSI over RDMA
    ok 6 image contains infiniband-diags package
    ok 7 image does not contain doc files
    ok 8 sminfo poll interval is 5 seconds

:warning: I need to figure out how to run acceptance tests
on a host without infiniband devices (such as CircleCI).
On a host with IB, `docker logs <cid>` could show output
similar to [`test/opensm.log`](test/opensm.log), which was
obtained on an unconfigured, tiny test fabric.


License
-------

See [LICENSE](LICENSE).
