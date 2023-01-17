package top.janker.jmall.demo.model;

import lombok.Builder;
import lombok.Data;

/**
 * @author janker
 * @date 2023/1/18 00:23
 * <p>
 * Blog: https://www.share-java.com
 * Github: https://github.com/janker0718
 */
@Data
@Builder
public class TestModel {
    private String name;

    private Integer age;
}
