package br.integration.cookmasterapi.controller;

import br.integration.cookmasterapi.dto.SacolaDto;
import br.integration.cookmasterapi.dto.VotoDto;
import br.integration.cookmasterapi.model.Sacola;
import br.integration.cookmasterapi.model.Voto;
import br.integration.cookmasterapi.services.SacolaService;
import br.integration.cookmasterapi.services.VotoService;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

@Api(description = "Controlador Rest responsável pelas operações que representam a o objeto usuario")
@RestController
@RequestMapping(path = "/sacola")
public class SacolaController {

    @Autowired
    private SacolaService sacolaService;

    @PostMapping
    public Sacola insert(@RequestBody @Valid SacolaDto sacolaDto) throws Exception {

        return sacolaService.insert(sacolaDto);

    }

    @PutMapping
    public Sacola edit(@RequestBody SacolaDto sacolaDto) throws Exception {

        return sacolaService.edit(sacolaDto);

    }

    @GetMapping
    public List<Sacola> findAll() throws Exception {

        return sacolaService.findAll();

    }

    @GetMapping(path = "/{id}")
    public Sacola findById(@PathVariable Long id) throws Exception {
        return sacolaService.findById(id);

    }

    @GetMapping(path = "/findSacolaByUsuario")
    public Sacola findSacolaByUsuario(@RequestParam Long usuarioId) throws Exception {
        return sacolaService.findByUsuarioId(usuarioId);
    }
}
