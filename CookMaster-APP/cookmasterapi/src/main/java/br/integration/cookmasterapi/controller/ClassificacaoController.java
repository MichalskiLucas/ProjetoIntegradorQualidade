package br.integration.cookmasterapi.controller;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import br.integration.cookmasterapi.model.Classificacao;
import br.integration.cookmasterapi.model.Receita;
import br.integration.cookmasterapi.services.ClassificacaoService;
import io.swagger.annotations.Api;

@Api(description = "Controlador Rest responsável pelas operações que representam a o objeto classificacao")
@RestController
@RequestMapping(path = "/classificacao")
public class ClassificacaoController {

	@Autowired
	private ClassificacaoService classificacaoService;

	@PostMapping
	public Classificacao insert(@RequestBody @Valid Classificacao classificacao) throws Exception {

		return classificacaoService.insert(classificacao);

	}

	@PutMapping
	public Classificacao edit(@RequestBody Classificacao classificacao) throws Exception {

		return classificacaoService.edit(classificacao);

	}

	@GetMapping
	public List<Classificacao> findAll() throws Exception {

		return classificacaoService.findAll();

	}
	
	@GetMapping(path = "/{id}")
	public Classificacao findById(@PathVariable Long id) throws Exception {
			return classificacaoService.findById(id);

	}
	
	@GetMapping(path = "/filter")
	public List<Classificacao> findByFilters(@RequestParam("descricao") Receita receita) {

			return classificacaoService.findByFilters(receita);

	}
}
