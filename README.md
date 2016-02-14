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


License
-------

See [LICENSE](LICENSE).
