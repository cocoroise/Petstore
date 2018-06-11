package com.petstore.service;

import com.petstore.util.Response;
import com.petstore.po.Pet;
import java.util.List;

public interface PetService {
    public Pet getPet(int id);

    public List<Pet> getPetByType(int type);

    public void addPet(Pet pet);

    Response deletePet(int id);

    public boolean updatePet(Pet pet);

    public List<Pet> getPetsByKeyWord(String searchKeyWord);

    public List<Pet> getAllPets();
}
