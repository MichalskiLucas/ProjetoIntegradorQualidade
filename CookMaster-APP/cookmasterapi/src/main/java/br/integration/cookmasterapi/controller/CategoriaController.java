package br.integration.cookmasterapi.controller;

import java.util.List;

import br.integration.cookmasterapi.dto.CategoriaDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import br.integration.cookmasterapi.services.CategoriaService;
import io.swagger.annotations.Api;

@Api(description = "Controlador Rest responsável pelas operações que representam a o objeto categoria")
@RestController
@RequestMapping(path = "/categoria")
public class CategoriaController {

    @Autowired
    private CategoriaService categoriaService;

    @PostMapping
    public CategoriaDto insert(@RequestBody CategoriaDto categoriaDto) throws Exception {

        return new CategoriaDto().getInstance(categoriaService.insert(categoriaDto));

    }

    @PutMapping
    public CategoriaDto edit(@RequestBody CategoriaDto categoriaDto) throws Exception {

        return new CategoriaDto().getInstance(categoriaService.edit(categoriaDto));
    }

    @GetMapping
    public List<CategoriaDto> findAll() throws Exception {
        return new CategoriaDto().getListInstance(categoriaService.findAll());
    }

    @GetMapping(path = "/{id}")
    public CategoriaDto findById(@PathVariable Long id) throws Exception {
        return new CategoriaDto().getInstance(categoriaService.findById(id));

    }

    @GetMapping(path = "/filter")
    public List<CategoriaDto> findByFilters(@RequestParam("descricao") String descricao) {

        return new CategoriaDto().getListInstance(categoriaService.findByFilters(descricao));

    }
}
