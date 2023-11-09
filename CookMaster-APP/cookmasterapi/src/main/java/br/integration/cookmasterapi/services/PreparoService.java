package br.integration.cookmasterapi.services;

import br.integration.cookmasterapi.dto.PreparoDto;
import br.integration.cookmasterapi.model.Preparo;
import br.integration.cookmasterapi.repository.PreparoRepository;
import br.integration.cookmasterapi.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class PreparoService {

    @Autowired
    private PreparoRepository preparoRepository;

    @Autowired
    private ReceitaService receitaService;


    public Preparo insert(PreparoDto dto) throws Exception {

        return preparoRepository.saveAndFlush(validarInsert(dto));

    }

    public Preparo edit(Preparo preparo) throws Exception {
        preparoRepository.saveAndFlush(preparo);
        return preparo;

    }

    public List<Preparo> findAll() {
        return preparoRepository.findAll();
    }

    public Preparo findById(Long id) throws Exception {
        Optional<Preparo> retorno = preparoRepository.findById(id);
        if (retorno.isPresent())
            return retorno.get();
        else
            throw new Exception("Preparo com ID: " + id + " não identificado!");
    }

    public List<Preparo> findByFilters(String descricao) {
        return preparoRepository.findByDescricaoContainingAllIgnoringCase(descricao);
    }

    private Preparo validarInsert(PreparoDto dto) throws Exception {
        Preparo p = new Preparo();
        if (dto.getId() != null) {
            throw new Exception("Não deve informar o ID para inserir o preparo");
        }

        p.setReceita(receitaService.findById(dto.getReceitaId()));
        p.setDescricao(dto.getDescricao());
        return p;
    }
}
