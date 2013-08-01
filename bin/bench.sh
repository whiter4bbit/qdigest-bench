TIMES=$1

JARS=""
for JAR in target/dependency/*.jar; do
  if [[ $JARS = "" ]]; then
    JARS="$JAR"
  else
    JARS="$JARS:$JAR"
  fi
done

MAIN_JAR="target/qdigest-bench-1.0-SNAPSHOT.jar"

for ((i=0;i<$TIMES;i++)); do
  java -server -Xmx1280m -verbose:gc -XX:+PrintGCDetails -XX:+PrintGCDateStamps -Xloggc:qdigest.log -cp $JARS:$MAIN_JAR QDigestInsertBenchmark
  GC_COUNT=`cat qdigest.log | grep PSYoung | grep -v total | wc -l`
  YOUNG_HEAP_USED=`cat qdigest.log| grep -e "PSYoungGen.*total" | sed -E s/".*used ([0-9]+).*"/"\1"/g`
  OLD_HEAP_USED=`cat qdigest.log| grep -e "ParOldGen.*total" | sed -E s/".*used ([0-9]+).*"/"\1"/g`
  echo "Young gen GC count: ${GC_COUNT}"
  echo "Young gen heap used (at the end): ${YOUNG_HEAP_USED}"
  echo "Old gen heap used (at the end): ${OLD_HEAP_USED}"
done
