package br.integration.cookmasterapi.controller;

import java.util.List;

import javax.validation.Valid;

import br.integration.cookmasterapi.dto.ReceitaDto;
import br.integration.cookmasterapi.dto.ReceitaIngredienteAuxDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import br.integration.cookmasterapi.services.ReceitaService;
import io.swagger.annotations.Api;

@Api(description = "Controlador Rest responsável pelas operações que representam a o objeto receita")
@RestController
@RequestMapping(path = "/receita")
public class ReceitaController {

	@Autowired
	private ReceitaService receitaService;

	@PostMapping
	public ReceitaDto insert(@RequestBody @Valid ReceitaDto receitaDto) throws Exception {

		return new ReceitaDto().getInstance(receitaService.insert(receitaDto));

	}
	@PostMapping(path = "/recipeComplete")
	public ReceitaIngredienteAuxDto receitaIgredienteComplete(@RequestBody @Valid ReceitaIngredienteAuxDto receitaAuxDto) throws Exception {

		return receitaService.insertRecipeComplete(receitaAuxDto);

	}

	@PutMapping
	public ReceitaDto edit(@RequestBody ReceitaDto receitaDto) throws Exception {

		return new ReceitaDto().getInstance(receitaService.edit(receitaDto));

	}

	@GetMapping
	public List<ReceitaDto> findAll() throws Exception {

		return new ReceitaDto().getListInstance(receitaService.findAll());

	}
	
	@GetMapping(path = "/{id}")
	public ReceitaDto findById(@PathVariable Long id) throws Exception {
		return new ReceitaDto().getInstance(receitaService.findById(id));

	}
	
	@GetMapping(path = "/filter")
	public List<ReceitaDto> findByFilters(@RequestParam("descricao") String descricao) {

		return new ReceitaDto().getListInstance(receitaService.findByFilters(descricao));

	}

	@GetMapping(path = "/findByCategoria")
	public List<ReceitaDto> findByCategoria(@RequestParam Long categoriaId) throws Exception {
		return new ReceitaDto().getListInstance(receitaService.findByCategoria(categoriaId));
	}

	@GetMapping(path = "/findTop")
	public List<ReceitaDto> findTopFive() {
		return new ReceitaDto().getListInstance(receitaService.findTopFive());
	}

	 /*
	- Receita por list de ingredientes
 */
}
