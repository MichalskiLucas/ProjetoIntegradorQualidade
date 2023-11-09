package br.integration.cookmasterapi.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import br.integration.cookmasterapi.enums.EnumUnitMeasure;
import io.swagger.models.Response;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import br.integration.cookmasterapi.model.Ingrediente;
import br.integration.cookmasterapi.services.IngredienteService;
import io.swagger.annotations.Api;

@Api(description = "Controlador Rest responsável pelas operações que representam a o objeto ingrediente")
@RestController
@RequestMapping(path = "/ingrediente")
public class IngredienteController {

    @Autowired
    private IngredienteService ingredienteService;

    @PostMapping
    public Ingrediente insert(@RequestBody @Valid Ingrediente ingrediente) throws Exception {

        return ingredienteService.insert(ingrediente);

    }

    @PutMapping
    public Ingrediente edit(@RequestBody Ingrediente ingrediente) throws Exception {

        return ingredienteService.edit(ingrediente);

    }

    @GetMapping
    public List<Ingrediente> findAll() throws Exception {

        return ingredienteService.findAll();

    }

    @GetMapping(path = "/{id}")
    public Ingrediente findById(@PathVariable Long id) throws Exception {
        return ingredienteService.findById(id);

    }

    @GetMapping(path = "/filter")
    public List<Ingrediente> findByFilters(@RequestParam("descricao") String descricao) {

        return ingredienteService.findByFilters(descricao);

    }

    @GetMapping(path = "/getUnitMeasure")
    public List<Map<String, String>> getContentType() {
        return ingredienteService.getUnitMeasure();
    }
}
