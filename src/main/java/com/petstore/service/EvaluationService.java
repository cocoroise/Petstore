package com.petstore.service;

import com.petstore.po.Evaluation;
import java.util.List;

public interface EvaluationService {
    public Evaluation getEvaluation(int userId, int productId, String time);

    public void addEvaluation(Evaluation evaluation);

    public boolean deleteEvaluation(int userId,int productId,String time);

    public boolean deleteEvaluationByProductId(int id);

    public boolean deleteEvaluationByUserId(int id);

    public boolean updateEvaluation(Evaluation evaluation);

    public List<Evaluation> getProductEvaluation(int productId);
}
