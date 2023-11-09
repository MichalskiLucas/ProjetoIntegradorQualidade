package br.integration.cookmasterapi.services;

import java.util.*;

import br.integration.cookmasterapi.enums.EnumUnitMeasure;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.integration.cookmasterapi.model.Ingrediente;
import br.integration.cookmasterapi.repository.IngredienteRepository;

@Service
public class IngredienteService {

	@Autowired
	private IngredienteRepository ingredienteRepository;

	@Autowired
	private EmailService emailService;
	
	public Ingrediente insert(Ingrediente ingrediente) throws Exception {

		validaInsert(ingrediente);
		Ingrediente i = ingredienteRepository.saveAndFlush(ingrediente);
		emailService.sendMail("kedssy533779@gmail.com", "ingrediente Criado", "Ingrediente com id: " + i.getId() +" criado");

		return i;
		
	}
	
	public Ingrediente edit(Ingrediente ingrediente) throws Exception {
		//validarEdicao(ingrediente);
		ingredienteRepository.saveAndFlush(ingrediente);
		return ingrediente;
		
	}
	
	public List<Ingrediente> findAll(){
		return ingredienteRepository.findAll();
	}
	
	public Ingrediente findById(Long id) throws Exception{
		Optional<Ingrediente> retorno =  ingredienteRepository.findById(id);
		if(retorno.isPresent())
			return retorno.get();
		else
			throw new Exception("Ingrediente com ID: " + id+" não identificado!");
	}
	
	public List<Ingrediente> findByFilters(String descricao) {
		return ingredienteRepository.findByDescricaoContainingAllIgnoringCase(descricao);
	}
	
	public Ingrediente findByDescricao(String descricao) {
		return ingredienteRepository.findIngredienteByDescricao(descricao);
	}
	
	public void validaInsert(Ingrediente ingrediente) throws Exception{
        if (ingrediente.getId() != null){
            throw new Exception("Não deve informar o ID para inserir o ingrediente");
        }
        if(findByDescricao(ingrediente.getDescricao()) != null){
        	throw new Exception("Ingrediente com a mesma descrição já inserido");
        }
    }

	public List<Map<String, String>> getUnitMeasure(){
		List<Map<String, String>> result = new ArrayList<>();
		for (EnumUnitMeasure e : EnumUnitMeasure.values()) {
			Map<String, String> m = new HashMap<>();
			m.put("value", String.valueOf(e.name()));
			m.put("descricao", e.getValue());
			result.add(m);
		}
		return result;
	}
}
