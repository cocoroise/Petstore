package com.petstore.service.impl;

import com.petstore.mapper.PetMapper;
import com.petstore.po.Pet;
import com.petstore.po.PetExample;
import com.petstore.service.PetService;
import com.petstore.util.Response;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("PetService")
public class PetServiceImpl implements PetService{

    @Autowired
    private PetMapper petMapper;
    @Autowired
    private EvaluationServiceImpl EvaluationService;

    @Override
    public Pet getPet(int id) {
        return petMapper.selectByPrimaryKey(id);
    }

    @Override
    public List<Pet> getPetByType(int type) {
        PetExample pe=new PetExample();
        PetExample.Criteria pec=pe.createCriteria();
        pec.andTypeEqualTo(type);
        return petMapper.selectByExample(pe);
    }

    @Override
    public void addPet(Pet pet) {
        petMapper.insert(pet);
    }

    @Override
    public Response deletePet(int id) {
        try{
            petMapper.deleteByPrimaryKey(id);
            //删除一个pet之后购物车还有记录要清除，写了别的类之后记得补这个
//            EvaluationService.deleteEvaluationByPetId(id);
            return new Response(1,"delete success",null);
        }catch (Exception e){
            return new Response(0,"delete fail",null);
        }
    }

    @Override
    public boolean updatePet(Pet pet) {
        return petMapper.updateByPrimaryKey(pet)>0;
    }

    @Override
    public List<Pet> getPetsByKeyWord(String searchKeyWord) {
        PetExample pe=new PetExample();
        PetExample.Criteria pec=pe.createCriteria();
        pec.andNameIsNotNull();
        pec.andKeyWordLike(searchKeyWord);
        return petMapper.selectByExample(pe);
    }

    @Override
    public List<Pet> getAllPets() {
        PetExample pe=new PetExample();
        PetExample.Criteria pec=pe.createCriteria();
        pec.andIdIsNotNull();
        pec.andNameIsNotNull();
        pe.setOrderByClause("id asc");
        return petMapper.selectByExample(pe);
    }
}
