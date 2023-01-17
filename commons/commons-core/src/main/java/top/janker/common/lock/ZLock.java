package top.janker.common.lock;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * @author janker
 * @date 2023/1/17 23:22
 * <p>
 * Blog: https://www.share-java.com
 * Github: https://github.com/janker0718
 */
@AllArgsConstructor
public class ZLock implements AutoCloseable {
    @Getter
    private final Object lock;

    private final DistributedLock locker;

    @Override
    public void close() throws Exception {
        locker.unlock(lock);
    }
}