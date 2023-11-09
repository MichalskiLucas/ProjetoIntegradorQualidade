package br.integration.cookmasterapi.controller;

import br.integration.cookmasterapi.model.ReceitaIngrediente;
import br.integration.cookmasterapi.services.ReceitaIngredienteService;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

@Api(description = "Controlador Rest responsável pelas operações que representam a o objeto ReceitaIngrediente")
@RestController
@RequestMapping(path = "/receitaIngrediente")
public class ReceitaIngredienteController {

    @Autowired
    private ReceitaIngredienteService receitaIngredienteService;

    @PostMapping
    public ReceitaIngrediente insert(@RequestBody @Valid ReceitaIngrediente receitaIngrediente) throws Exception {

        return receitaIngredienteService.insert(receitaIngrediente);

    }

    @PutMapping
    public ReceitaIngrediente edit(@RequestBody ReceitaIngrediente receitaIngrediente) throws Exception {

        return receitaIngredienteService.edit(receitaIngrediente);

    }

    @GetMapping
    public List<ReceitaIngrediente> findAll() throws Exception {

        return receitaIngredienteService.findAll();

    }

    @GetMapping(path = "/{id}")
    public ReceitaIngrediente findById(@PathVariable Long id) throws Exception {
        return receitaIngredienteService.findById(id);

    }

    @GetMapping(path = "/filter")
    public List<ReceitaIngrediente> findByFilters(@RequestParam("descricao") String descricao) {

        return receitaIngredienteService.findByFilters(descricao);

    }
}
