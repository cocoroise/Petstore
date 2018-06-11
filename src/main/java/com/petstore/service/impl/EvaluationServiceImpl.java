package com.petstore.service.impl;

import com.petstore.mapper.EvaluationMapper;
import com.petstore.po.Evaluation;
import com.petstore.po.EvaluationExample;
import com.petstore.po.EvaluationKey;
import com.petstore.service.EvaluationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("EvaluationService")
public class EvaluationServiceImpl implements EvaluationService {

    @Autowired
    private EvaluationMapper EvaluationMapper;

    @Override
    public Evaluation getEvaluation(int userId, int productId, String time) {
        EvaluationKey pek=new EvaluationKey();
        pek.setUserid(userId);
        pek.setCommodityid(productId);
        pek.setTime(time);
        return EvaluationMapper.selectByPrimaryKey(pek);
    }

    @Override
    public void addEvaluation(Evaluation evaluation) {
        EvaluationMapper.insert(evaluation);
    }

    @Override
    public boolean deleteEvaluation(int userId, int productId, String time) {
        EvaluationKey pek=new EvaluationKey();
        pek.setUserid(userId);
        pek.setCommodityid(productId);
        pek.setTime(time);
        return EvaluationMapper.deleteByPrimaryKey(pek)>0;
    }

    @Override
    public boolean deleteEvaluationByProductId(int id) {
        EvaluationExample example=new EvaluationExample();
        EvaluationExample.Criteria peec=example.createCriteria();
        peec.andCommodityidIsNotNull();
        peec.andCommodityidEqualTo(id);
        return EvaluationMapper.deleteByExample(example)>0;
    }

    @Override
    public boolean deleteEvaluationByUserId(int id) {
        EvaluationExample example=new EvaluationExample();
        EvaluationExample.Criteria peec=example.createCriteria();
        peec.andUseridIsNotNull();
        peec.andUseridEqualTo(id);
        return EvaluationMapper.deleteByExample(example)>0;
    }

    @Override
    public boolean updateEvaluation(Evaluation evaluation) {
        return EvaluationMapper.updateByPrimaryKey(evaluation)>0;
    }

    @Override
    public List<Evaluation> getProductEvaluation(int productId) {
        EvaluationExample example=new EvaluationExample();
        EvaluationExample.Criteria peec=example.createCriteria();
        peec.andCommodityidIsNotNull();
        example.setOrderByClause("id asc");
        List<Evaluation> list=EvaluationMapper.selectByExample(example);
        return list;
    }
}
