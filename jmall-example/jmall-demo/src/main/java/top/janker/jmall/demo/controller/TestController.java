package top.janker.jmall.demo.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import top.janker.jmall.demo.model.BaseResult;
import top.janker.jmall.demo.model.TestModel;

/**
 * @author janker
 * @date 2023/1/18 00:21
 * <p>
 * Blog: https://www.share-java.com
 * Github: https://github.com/janker0718
 */
@RestController("/test")
public class TestController {


    @GetMapping("/hello")
    @ResponseBody
    public BaseResult<TestModel> hello(@RequestParam("name") String name){
        return BaseResult.success(TestModel.builder().name(name).build());
    }

}
