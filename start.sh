#!/bin/sh
echo "\n" >> /opt/kafka/config/server.properties
echo "listeners=PLAINTEXT://0.0.0.0:9092" >> /opt/kafka/config/server.properties
echo "zookeeper.connect=$ZOOK" >> /opt/kafka/config/server.properties
echo "auto.create.topics.enable=true" >> /opt/kafka/config/server.properties
echo "num.partitions=10" >> /opt/kafka/config/server.properties
echo "delete.topic.enable=true\n" >> /opt/kafka/config/server.properties

echo "
k() {
	echo \"list, count $1, consume $1, cleartopic $1, desc $1, alter $1, $2 publish $1\"
}

list() {
	/opt/kafka/bin/kafka-topics.sh --zookeeper $ZOOK --list
}

count() {
	/opt/kafka/bin/kafka-run-class.sh kafka.tools.GetOffsetShell --broker-list localhost:9092 --topic \"\$1\" --time -1 |cut -c 22- | awk '{total = total + \$1}END{print total}'
}

consume() {
	/opt/kafka/bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic \"\$1\" --from-beginning
}

cleartopic() {
	/opt/kafka/bin/kafka-topics.sh --delete --zookeeper $ZOOK --topic \"\$1\"
}

desc() {
	/opt/kafka/bin/kafka-topics.sh --describe --zookeeper $ZOOK --topic \"\$1\" | more
}

publish() {
	/opt/kafka/bin/kafka-console-producer.sh --broker-list localhost:9092 --topic \"\$1\"
}

alter() {
	/opt/kafka/bin/kafka-topics.sh --alter --zookeeper $ZOOK --topic \"\$1\" --partitions \"\$2\"
}
" >> ~/.bashrc

/opt/kafka/bin/kafka-server-start.sh /opt/kafka/config/server.properties
