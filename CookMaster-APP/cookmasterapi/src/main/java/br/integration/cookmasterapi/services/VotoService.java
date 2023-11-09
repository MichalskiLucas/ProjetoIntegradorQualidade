package br.integration.cookmasterapi.services;

import br.integration.cookmasterapi.dto.VotoDto;
import br.integration.cookmasterapi.model.Receita;
import br.integration.cookmasterapi.model.Voto;
import br.integration.cookmasterapi.repository.ReceitaRepository;
import br.integration.cookmasterapi.repository.VotoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.persistence.NoResultException;
import java.util.List;
import java.util.Optional;

@Service
public class VotoService {

    @Autowired
    private VotoRepository votoRepository;

    @Autowired
    private ReceitaRepository receitaRepository;

    @Autowired
    private UsuarioService usuarioService;

    @Autowired
    private ReceitaService receitaService;


    public Voto insert(VotoDto votoDto) throws Exception {
        Voto voto = new Voto();
        voto.setUsuario(usuarioService.findById(votoDto.getIdUsuario()));
        voto.setReceita(receitaService.findById(votoDto.getIdReceita()));
        voto.setVoto(votoDto.getVoto());
        if(votoDto.getId() != null)
            voto.setId(votoDto.getId());
        validaInsert(voto);
        votoRepository.saveAndFlush(voto);
        return voto;

    }

    public Voto edit(VotoDto votoDto) throws Exception {
        Voto voto = new Voto();
        voto.setId(votoDto.getId());
        voto.setUsuario(usuarioService.findById(votoDto.getIdUsuario()));
        voto.setReceita(receitaService.findById(votoDto.getIdReceita()));
        voto.setVoto(votoDto.getVoto());
        validaUpdate(voto);
        votoRepository.saveAndFlush(voto);
        return voto;

    }

    public List<Voto> findAll() {
        return votoRepository.findAll();
    }

    public Voto findById(Long id) throws Exception {
        Optional<Voto> retorno = votoRepository.findById(id);
        if (retorno.isPresent()) return retorno.get();
        else throw new Exception("Voto com ID: " + id + " não identificado!");
    }

    public List<Voto> findByReceitaId(Long receitaId) {
        try{
            return votoRepository.findVotoByReceitaId(Optional.ofNullable(receitaId));
        }catch (NoResultException ex){
            return null;
        }

    }

    public Voto findByUsuarioId(Long usuarioId, Long receitaId) {
        return votoRepository.findVotoByUsuarioIdAndReceitaId(Optional.ofNullable(usuarioId), Optional.ofNullable(receitaId));
    }

    private void validaInsert(Voto voto) throws Exception {
        if (voto.getId() != null)
            throw new Exception("Para inserir um voto, não deve-se informar o ID");
    }

    private void validaUpdate(Voto voto) throws Exception {

        if (voto.getId() == null || voto.getId() == 0)
            throw new Exception("Para atualizar um voto, deve-se informar o ID.");
    }
}
