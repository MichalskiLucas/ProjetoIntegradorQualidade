package br.integration.cookmasterapi.services;

import java.util.List;
import java.util.Optional;

import br.integration.cookmasterapi.dto.CategoriaDto;
import br.integration.cookmasterapi.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.integration.cookmasterapi.model.Categoria;
import br.integration.cookmasterapi.repository.CategoriaRepository;

@Service
public class CategoriaService {

    @Autowired
    private CategoriaRepository categoriaRepository;


    public Categoria insert(CategoriaDto dto) throws Exception {
        return categoriaRepository.saveAndFlush(validaInsert(dto));
    }

    public Categoria edit(CategoriaDto dto) throws Exception {
        return categoriaRepository.saveAndFlush(validaUpdate(dto));
    }

    public List<Categoria> findAll() {
        return categoriaRepository.findAll();
    }

    public Categoria findById(Long id) throws Exception {
        Optional<Categoria> retorno = categoriaRepository.findById(id);
        if (retorno.isPresent())
            return retorno.get();
        else
            throw new Exception("Categoria com ID: " + id + " não identificado!");
    }

    public Categoria find(Long id) throws Exception {
        try {
            Optional<Categoria> retorno = categoriaRepository.findById(id);
            if (retorno.isPresent())
                return retorno.get();
            else
                return null;
        } catch (Exception e) {
            return null;
        }

    }

    public List<Categoria> findByFilters(String descricao) {
        return categoriaRepository.findByDescricaoContainingAllIgnoringCase(descricao);
    }

    public Categoria findByDescricao(String descricao) {
        return categoriaRepository.findCategoriaByDescricao(descricao);
    }

    public Categoria validaInsert(CategoriaDto dto) throws Exception {

        Categoria c = new Categoria();
        c = findByDescricao(dto.getDescricao());
        if (findByDescricao(dto.getDescricao()) != null) {
            throw new Exception("Categoria com a mesma descrição já inserido");
        }
        if (dto.getId() != 0)
            throw new Exception("Para inserir uma nova categoria, não deve-se informar o ID");

        c.setId(dto.getId());
        c.setDescricao(dto.getDescricao());
        if(dto.getImagem() != null)
            c.setImagem(Util.compressData(dto.getImagem()));
        return c;

    }

    private Categoria validaUpdate(CategoriaDto dto) throws Exception {

        if (dto.getId() == null)
            throw new Exception("Para atualizar uma categoria, deve-se informar o ID");

        Categoria c = findById(dto.getId());

        if (findByDescricao(dto.getDescricao()) != null && !c.getDescricao().equals(dto.getDescricao()))
            throw new Exception("Categoria com a mesma descrição já inserido");

        c.setId(dto.getId());
        c.setDescricao(dto.getDescricao());
        c.setImagem(Util.compressData(dto.getImagem()));
        return c;

    }
}
