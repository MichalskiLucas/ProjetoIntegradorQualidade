package br.integration.cookmasterapi.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.integration.cookmasterapi.model.Usuario;
import br.integration.cookmasterapi.repository.UsuarioRepository;

@Service
public class UsuarioService {

    @Autowired
    private UsuarioRepository usuarioRepository;


    public Usuario insert(Usuario usuario) throws Exception {

        validaInsert(usuario);
        usuarioRepository.saveAndFlush(usuario);
        return usuario;

    }

    public Usuario edit(Usuario usuario) throws Exception {

        usuarioRepository.saveAndFlush(usuario);
        return usuario;

    }

    public List<Usuario> findAll() {
        return usuarioRepository.findAll();
    }

    public Usuario findById(Long id) throws Exception {
        Optional<Usuario> retorno = usuarioRepository.findById(id);
        if (retorno.isPresent())
            return retorno.get();
        else
            throw new Exception("Ingrediente com ID: " + id + " não identificado!");
    }

    public List<Usuario> findByFilters(String nome) {
        return usuarioRepository.findByNomeContainingAllIgnoringCase(nome);
    }

    public List<Usuario> findAdmin() {
        return usuarioRepository.findUsuariosByAdminIsTrue();
    }

    public Usuario findByNome(String nome) {
        return usuarioRepository.findUsuarioByNome(nome);
    }

    public Usuario findByEmail(String email) {
        return usuarioRepository.findUsuarioByEmail(email);
    }

    public void validaInsert(Usuario usuario) throws Exception {
        if (usuario.getId() != null) {
            throw new Exception("Não deve informar o ID para inserir o ususario");
        }
        if (findByNome(usuario.getNome()) != null) {
            throw new Exception("ususario com o mesmo nome já inserido");
        }

        if (findByNome(usuario.getEmail()) != null) {
            throw new Exception("ususario com o mesmo email já inserido");
        }
    }
}
