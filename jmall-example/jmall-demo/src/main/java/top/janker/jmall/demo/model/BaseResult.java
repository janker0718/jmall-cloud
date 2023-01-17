package top.janker.jmall.demo.model;

import lombok.Data;

/**
 * @author janker
 * @date 2023/1/18 00:23
 * <p>
 * Blog: https://www.share-java.com
 * Github: https://github.com/janker0718
 */
@Data
public class BaseResult<T> {

    public static String SUCCESS_CODE = "200";

    public static String SUCCESS_MSG = "成功";

    private String code;

    private String msg;

    private T data;

    public BaseResult(String code, String msg,T data) {
        this.code = code;
        this.msg = msg;
        this.data = data;
    }

    public BaseResult(String code,T data) {
        this.code = code;
        this.msg = msg;
        this.data = data;
    }
    public static <T> BaseResult<T>  success(T data){
        return new BaseResult<>(SUCCESS_CODE,SUCCESS_MSG,data);
    }
}
