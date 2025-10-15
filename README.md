# Minimal ILDG storage element

Intended setup:

- A server on an internal network with a large volume needing sharing
- A gateway server on the same network but with inbound internet access

Files will be served from the server only to the gateway via HTTPS with a self-signed certificate,
and from the gateway to anywhere via a LetsEncrypt certificate

## Setup

### Storage server

1. Clone the repository.

2. Ensure that `docker` and `docker compose`
   (or `podman` and `podman compose`),
   and `openssl`
   are installed.

3. Enter the `storage` directory
   ```
   cd storage
   ```

4. Run `generate_key.sh`,
   with the hostname of the storage server as the argument.
   ```
   ./generate_key.sh ildg-storage.example.net
   ```

5. Edit `nginx/conf/app.conf`:

   1. Replace `lattice-storage-park.swansea.ac.uk`
      with the hostname of the storage server.
   2. Replace the `allow` lines with ones allowing access to the IP range(s) of the gateway server.
   3. Replace the `root /data` with `root` followed by the path to where the data you want to serve live.

6. Start the daemon:
   ```
   docker compose up -d
   ```

7. Edit your `crontab` such that this is done automatically at startup.

### Gateway

1. Clone the repository.

2. Ensure that `docker` and `docker compose`
   (or `podman` and `podman compose`),
   and `openssl`
   are installed.

3. Enter the `storage` directory
   ```
   cd gateway
   ```

4. Start the servers
   ```
   podman compose up -d
   ```

4. Register with LetsEncrypt,
   giving the hostnames of the gateway server as arguments
   ```
   ./get_certificate.sh ildg-gateway.example.net ildg-gateway.example.org
   ```

5. Edit `nginx/conf/app.conf`

   1. Replace `uklft-dg.swan.ac.uk`, `uklft-dg.swansea.ac.uk`, and `uklft-dg.abertawe.ac.uk`
      with the hostname of the gateway server.
   2. Replace `lattice-storage-park.swansea.ac.uk` with the hostname of the storage server.

6. Restart the server

   ```
   podman compose restart
   ```

6. Edit your `crontab`

   1. Start the server with `podman compose up -d` on each boot

   2. Renew the SSL certificate with `podman compose run --rm certbot renew` every month.

   In each case,
   this needs to run in the `gateway` directory.
