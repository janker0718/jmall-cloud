package top.janker.jmall.demo.controller;

import com.alibaba.fastjson.JSON;
import lombok.extern.slf4j.Slf4j;
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
@RestController
@Slf4j
public class TestController {


    @GetMapping("/hello")
    @ResponseBody
    public BaseResult<TestModel> hello(@RequestParam("name") String name){
        log.info("name:{}",name);
        BaseResult<TestModel> baseResult = BaseResult.success(TestModel.builder().name(name).build());
        log.info("baseResult:{}", JSON.toJSONString(baseResult));
        return baseResult;
    }

}
