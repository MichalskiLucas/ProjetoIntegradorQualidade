package br.integration.cookmasterapi.controller;

import br.integration.cookmasterapi.dto.VotoDto;
import br.integration.cookmasterapi.model.Voto;
import br.integration.cookmasterapi.services.VotoService;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

@Api(description = "Controlador Rest responsável pelas operações que representam a o objeto usuario")
@RestController
@RequestMapping(path = "/voto")
public class VotoController {

    @Autowired
    private VotoService votoService;

    @PostMapping
    public Voto insert(@RequestBody @Valid VotoDto votoDto) throws Exception {

        return votoService.insert(votoDto);

    }

    @PutMapping
    public Voto edit(@RequestBody VotoDto votoDto) throws Exception {

        return votoService.edit(votoDto);

    }

    @GetMapping
    public List<Voto> findAll() throws Exception {

        return votoService.findAll();

    }

    @GetMapping(path = "/{id}")
    public Voto findById(@PathVariable Long id) throws Exception {
        return votoService.findById(id);

    }

    @GetMapping(path = "/findVotoByReceita/{receitaId}")
    public List<Voto> findVotoByReceitaId(@PathVariable Long receitaId) throws Exception {
        return votoService.findByReceitaId(receitaId);
    }

    @GetMapping(path = "/findVotoByUsuario")
    public Voto findVotoByUsuarioId(@RequestParam Long usuarioId, @RequestParam Long receitaId) throws Exception {
        return votoService.findByUsuarioId(usuarioId, receitaId);
    }
}
