# maintainer Pham Kieu Thanh
FROM anapsix/alpine-java:8
ADD start.sh start.sh
ADD kafka_2.11-0.11.0.1 /opt/kafka/
CMD ["./start.sh"]
