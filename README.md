# Apache Traffic Server - Docker 

Docker container for running Apache Traffic Server [https://trafficserver.apache.org/].


## Versions
--------

OS and Traffic Server versions are pinned.

* OS: Ubuntu Jammy
* Traffic Server: 9.1.2


## Configuration

Default Apache Traffic Server configuration is provided in `/etc/trafficserver`.

Please mount a volume containing your Traffic Server configuration into `/etc/trafficserver` on the container, e.g.:

`docker run -d --restart always --name ats -p 8080:8080 --mount type=bind,source=/path/to/config,target=/etc/trafficserverkingsdigitallab/trafficserver`

If your configuration specifies ports other than 8080, please modify the above. The image exposes `80`, `443` and `8080`.


## Usage

To run with Apache supplied default conf for testing/development, run:

`docker run -d --restart always --name ats -p 8080:8080 kingsdigitallab/trafficserver`

To run with your own configuration, see `Configuration`

## Building

No special tools required, simply:

`docker build -t x/trafficserver .`

## Known Issues

* None!
