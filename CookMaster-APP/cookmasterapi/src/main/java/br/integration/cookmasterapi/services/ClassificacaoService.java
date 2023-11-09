package br.integration.cookmasterapi.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.integration.cookmasterapi.model.Classificacao;
import br.integration.cookmasterapi.model.Receita;
import br.integration.cookmasterapi.repository.ClassificacaoRepository;

@Service
public class ClassificacaoService {

	@Autowired
	private ClassificacaoRepository classificacaoRepository;
	
	
	public Classificacao insert(Classificacao classificacao) throws Exception {
		//validarInsert(classificacao);
		classificacaoRepository.saveAndFlush(classificacao);
		return classificacao;
		
	}
	
	public Classificacao edit(Classificacao classificacao) throws Exception {
		classificacaoRepository.saveAndFlush(classificacao);
		return classificacao;
		
	}
	
	public List<Classificacao> findAll(){
		return classificacaoRepository.findAll();
	}
	
	public Classificacao findById(Long id) throws Exception{
		Optional<Classificacao> retorno =  classificacaoRepository.findById(id);
		if(retorno.isPresent())
			return retorno.get();
		else
			throw new Exception("Classificacao com ID: " + id+" não identificada!");
	}
	
	public List<Classificacao> findByFilters(Receita receita) {
		return classificacaoRepository.findByReceita(receita);
	}
	
}
