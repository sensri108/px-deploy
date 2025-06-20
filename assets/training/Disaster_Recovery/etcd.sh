# Run an etcd container
docker run -d --restart unless-stopped -p 2382:2382 \
 -e ETCD_LISTEN_CLIENT_URLS=http://0.0.0.0:2382 \
 -e ETCD_NAME=etcd0 \
 -e ETCD_ADVERTISE_CLIENT_URLS=http://$(hostname -i):2382 \
 --name etcd docker.io/bitnami/etcd:3.5.21 \
 /opt/bitnami/etcd/bin/etcd \
 -auto-compaction-retention=3 -quota-backend-bytes=8589934592
