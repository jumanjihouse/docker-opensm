OpenSM Infiniband Subnet Manager
================================


[![download size](https://images.microbadger.com/badges/image/jumanjiman/opensm.svg)](http://microbadger.com/images/jumanjiman/opensm "View on microbadger.com")
[![version](https://images.microbadger.com/badges/version/jumanjiman/opensm.svg)](http://microbadger.com/images/jumanjiman/opensm "View on microbadger.com")
[![license](https://images.microbadger.com/badges/license/jumanjiman/opensm.svg)](http://microbadger.com/images/jumanjiman/opensm "View on microbadger.com")
[![Docker Registry](https://img.shields.io/docker/pulls/jumanjiman/opensm.svg)](https://registry.hub.docker.com/u/jumanjiman/opensm/)&nbsp;
[![Circle CI](https://circleci.com/gh/jumanjihouse/docker-opensm.png?circle-token=49cfeda576ec04d63924da128e314e8796b173fa)](https://circleci.com/gh/jumanjihouse/docker-opensm/tree/master 'View CI builds')

Project URL: [https://github.com/jumanjihouse/docker-opensm](https://github.com/jumanjihouse/docker-opensm)
<br />
Docker hub: [https://registry.hub.docker.com/u/jumanjiman/opensm/](https://registry.hub.docker.com/u/jumanjiman/opensm/)

**Table of Contents**

- [Overview](#overview)
  - [Build integrity](#build-integrity)
- [How-to](#how-to)
  - [Build locally](#build-locally)
  - [Pull an already-built image](#pull-an-already-built-image)
  - [Run OpenSM](#run-opensm)
  - [Run diagnostics](#run-diagnostics)
  - [Test](#test)
- [License](#license)


Overview
--------

OpenSM is an infiniband subnet manager from the
OpenFabrics Enterprise Distribution (OFED).
This repo provides a way to build OpenSM
into a docker image and run it as a container.


### Build integrity

The repo is set up to build the image on CircleCI.

![workflow](assets/docker_hub_workflow.png)

An unattended test harness runs simple test scripts.
If all tests pass on master branch in the unattended test harness,
it pushes the built images to the Docker hub.


How-to
------


### Build locally

On a host with Docker:

    docker build --rm -t opensm src/


### Pull an already-built image

These images are built as part of the test harness on CircleCI.
If all tests pass on master branch, then the image is pushed into the docker hub.

    docker pull jumanjiman/opensm:latest

The `latest` tag always points to the latest version.
Additional tags include `7-${build_datetime}-${git_hash}`
to correlate any image to both the opensm version and a git commit from this repo.
The `7` in the tag refers to the fact that this image is based on Centos 7.

We push the tags automatically from the test harness, and
we occasionally delete old tags from the Docker hub by hand.


### Run OpenSM

On a host with Docker:

    docker run -d \
      --name opensm.service
      --read-only \
      --memory=10G \
      --privileged \
      --net=host \
      -v /lib/modules:/lib/modules:ro \
      jumanjiman/opensm

On a host with IB, `docker logs <cid>` could show output
similar to [`test/opensm.log`](test/opensm.log), which was
obtained on an unconfigured, tiny test fabric.


### Run diagnostics

The image contains useful infiniband diagnostic utilities from these packages:

* ibutils
* infiniband-diags
* qperf

You can run the tools in two ways:

* Enter a running opensm container via `docker exec -it <cid> bash`
  and call the utils directly.

* Start a fresh container with something like:

  ```
  docker run --rm -it --net=host --privileged --entrypoint bash jumanjiman/opensm
  ```

Sample output from `ibnetdiscover` (one of the utils) is shown at
[`test/ibnetdiscover.out`](test/ibnetdiscover.out).


### Test

Run the test harness:

    ci/test

The test harness requires:

* [BATS](https://github.com/bats-core/bats-core)
* Python and the `pip` command

Output resembles:

    [yamllint] yamllint..........................................................................Passed
    [check-added-large-files] Check for added large files........................................Passed
    [check-case-conflict] Check for case conflicts...............................................Passed
    [check-executables-have-shebangs] Check that executables have shebangs.......................Passed
    [check-symlinks] Check for broken symlinks...............................(no files to check)Skipped
    [check-vcs-permalinks] Check vcs permalinks..................................................Passed
    [detect-private-key] Detect Private Key......................................................Passed
    [forbid-crlf] CRLF end-lines checker.........................................................Passed
    [forbid-tabs] No-tabs checker................................................................Passed
    [forbid-binary] Forbid binaries..........................................(no files to check)Skipped
    [git-check] Check for conflict markers and core.whitespace errors............................Passed
    [git-dirty] Check if the git tree is dirty...................................................Passed
    [shellcheck] Test shell scripts with shellcheck..............................................Passed
    [shfmt] Check shell style with shfmt.........................................................Passed

    1..33
    ok 1 LICENSE file exists
    ok 2 image exists
    ok 3 image contains opensm package
    ok 4 RDMA config allows IPoIB
    ok 5 RDMA config does not load iSCSI over RDMA
    ok 6 image contains infiniband-diags package
    ok 7 image does not contain doc files
    ok 8 image contains ibutils package
    ok 9 ibdiagnet is in path
    ok 10 image contains qperf package
    ok 11 qperf is in path
    ok 12 userspace ib driver "infinipath-psm" is installed
    ok 13 userspace ib driver "libcxgb3" is installed
    ok 14 userspace ib driver "libcxgb4" is installed
    ok 15 userspace ib driver "libipathverbs" is installed
    ok 16 userspace ib driver "libmthca" is installed
    ok 17 userspace ib driver "libmlx4" is installed
    ok 18 userspace ib driver "libmlx5" is installed
    ok 19 userspace ib driver "libnes" is installed
    ok 20 userspace ib driver "libocrdma" is installed
    ok 21 connection mgmt library "librdmacm" is installed
    ok 22 connection mgmt library "librdmacm-utils" is installed
    ok 23 connection mgmt library "ibacm" is installed
    ok 24 "libibverbs" is installed
    ok 25 "libibverbs-utils" is installed
    ok 26 "ibv_devinfo" is in path
    ok 27 "libibcommon" is installed
    ok 28 "dapl" is installed
    ok 29 "compat-dapl" is installed
    ok 30 "dapl-utils" is installed
    ok 31 "compat-dapl-utils" is installed
    ok 32 "mstflint" is installed
    ok 33 sminfo poll interval is 5 seconds

:warning: I need to figure out how to run acceptance tests
on a host without infiniband devices (such as CircleCI).


License
-------

See [LICENSE](LICENSE).
