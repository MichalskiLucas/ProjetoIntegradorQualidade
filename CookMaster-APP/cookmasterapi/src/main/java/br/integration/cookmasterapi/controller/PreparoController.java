package br.integration.cookmasterapi.controller;

import br.integration.cookmasterapi.model.Preparo;
import br.integration.cookmasterapi.services.PreparoService;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

@Api(description = "Controlador Rest responsável pelas operações que representam a o objeto Preparo")
@RestController
@RequestMapping(path = "/preparo")
public class PreparoController {

    @Autowired
    private PreparoService preparoService;

    @PostMapping
    public Preparo insert(@RequestBody @Valid Preparo preparo) throws Exception {

        return preparoService.insert(preparo);

    }

    @PutMapping
    public Preparo edit(@RequestBody Preparo preparo) throws Exception {

        return preparoService.edit(preparo);

    }

    @GetMapping
    public List<Preparo> findAll() throws Exception {

        return preparoService.findAll();

    }

    @GetMapping(path = "/{id}")
    public Preparo findById(@PathVariable Long id) throws Exception {
        return preparoService.findById(id);

    }

    @GetMapping(path = "/filter")
    public List<Preparo> findByFilters(@RequestParam("descricao") String descricao) {

        return preparoService.findByFilters(descricao);

    }
}
