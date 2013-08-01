/*
 * Copyright (c) Sematext International
 * All Rights Reserved
 * <p/>
 * THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF Sematext International
 * The copyright notice above does not evidence any
 * actual or intended publication of such source code.
 */

import com.clearspring.analytics.stream.quantile.QDigest;

import java.util.concurrent.ThreadLocalRandom;

public class QDigestInsertBenchmark {
  public static void main(String[] args) {
    QDigest qdigest = new QDigest(168);

    ThreadLocalRandom random = ThreadLocalRandom.current();

    long start = System.currentTimeMillis();

    for (int i = 0; i < 50000000; i++) {
      qdigest.offer(Math.abs(random.nextInt(120000)));
    }

    long end = System.currentTimeMillis() - start;

    System.out.println("Insert:" + end);
  }
}
