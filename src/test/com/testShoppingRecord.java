package com;

import com.petstore.po.ShoppingRecord;
import com.petstore.service.ShoppingCarRecordService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class testShoppingRecord {
    @Autowired
    private ShoppingCarRecordService shoppingCarRecordService;

    @Test
    public void testGetShoppingRecord(){
        List<ShoppingRecord> shoppingRecordList=shoppingCarRecordService.getShoppingRecords(100);
        System.out.println(shoppingRecordList.size());
    }

    @Test
    public void testAddShoppingRecord(){
        ShoppingRecord s=new ShoppingRecord();
        s.setUserId(100);
        s.setProductId(1);
        s.setPrice(2002.0);
        s.setOrderStatus(2);
        s.setCount(1);
        s.setTime("2018-3-24");
        shoppingCarRecordService.addShoppingRecord(s);
    }

}
