package top.janker.common.exception;

/**
 * 分布式锁异常
 * @author janker
 * @date 2023/1/17 23:41
 * <p>
 * Blog: https://www.share-java.com
 * Github: https://github.com/janker0718
 */
public class LockException extends RuntimeException {
    private static final long serialVersionUID = 6610083281801529147L;

    public LockException(String message) {
        super(message);
    }
}