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

import br.integration.cookmasterapi.model.Usuario;
import br.integration.cookmasterapi.services.UsuarioService;
import io.swagger.annotations.Api;

@Api(description = "Controlador Rest responsável pelas operações que representam a o objeto usuario")
@RestController
@RequestMapping(path = "/usuario")
public class UsuarioController {

	@Autowired
	private UsuarioService usuarioService;

	@PostMapping
	public Usuario insert(@RequestBody @Valid Usuario usuario) throws Exception {

		return usuarioService.insert(usuario);

	}

	@PutMapping
	public Usuario edit(@RequestBody Usuario usuario) throws Exception {

		return usuarioService.edit(usuario);

	}

	@GetMapping
	public List<Usuario> findAll() throws Exception {

		return usuarioService.findAll();

	}
	
	@GetMapping(path = "/{id}")
	public Usuario findById(@PathVariable Long id) throws Exception {
			return usuarioService.findById(id);

	}
	
	@GetMapping(path = "/filter")
	public List<Usuario> findByFilters(@RequestParam("nome") String nome) {

			return usuarioService.findByFilters(nome);

	}

	@GetMapping(path = "/filterEmail")
	public Usuario findByEmail(@RequestParam("email") String email) {

		return usuarioService.findByEmail(email);

	}
}
