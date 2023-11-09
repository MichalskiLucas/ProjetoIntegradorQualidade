package br.integration.cookmasterapi.services;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import br.integration.cookmasterapi.dto.PreparoDto;
import br.integration.cookmasterapi.dto.ReceitaDto;
import br.integration.cookmasterapi.dto.ReceitaIngredienteAuxDto;
import br.integration.cookmasterapi.dto.ReceitaIngredienteDto;
import br.integration.cookmasterapi.model.ReceitaIngrediente;
import br.integration.cookmasterapi.model.Usuario;
import br.integration.cookmasterapi.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.integration.cookmasterapi.model.Categoria;
import br.integration.cookmasterapi.model.Receita;
import br.integration.cookmasterapi.repository.ReceitaRepository;

@Service
public class ReceitaService {

    @Autowired
    private ReceitaRepository receitaRepository;

    @Autowired
    private UsuarioService usuarioService;

    @Autowired
    private EmailService emailService;

    @Autowired
    private PreparoService preparoService;


    @Autowired
    private CategoriaService categoriaService;


    public Receita insert(ReceitaDto dto) throws Exception {
        Receita r = receitaRepository.saveAndFlush(validaInsert(dto));
        sendEmailForAdmin(r);
        return r;

    }

    public ReceitaIngredienteAuxDto insertRecipeComplete(ReceitaIngredienteAuxDto dto) throws Exception {

        ReceitaDto receitaDto = new ReceitaDto();

        Usuario usuario = usuarioService.findById(dto.getUsuarioId());

        receitaDto.setUsuario(usuario);
        receitaDto.setDescricao(dto.getDsReceita());
        receitaDto.setImagem(dto.getImgReceita());
        receitaDto.setVoto(0);
        receitaDto.setCategoriaId(dto.getCategoriaId());
        Receita r = insert(receitaDto);

        if (!dto.getPreparos().isEmpty()) {
            for (int i = 0; i < dto.getPreparos().size(); i++) {
                PreparoDto preparoDto = new PreparoDto();
                preparoDto.setReceitaId(r.getId());
                preparoDto.setDescricao(dto.getPreparos().get(i).getDescricao());
                preparoService.insert(preparoDto);
            }
        }


        for (int i = 0; i < dto.getIngredientes().size(); i++) {
            ReceitaIngredienteDto receitaIngredienteDto = new ReceitaIngredienteDto();
            receitaIngredienteDto.setReceitaId(r.getId());
            receitaIngredienteDto.setIngredienteId(dto.getIngredientes().get(i).getIngredienteId());
            receitaIngredienteDto.setQtdIngrediente(dto.getIngredientes().get(i).getQtdIngrediente());
            receitaIngredienteDto.setUnMedida(dto.getIngredientes().get(i).getUnMedida());


        }
        return dto;

    }

    public void sendEmailForAdmin(Receita r) throws Exception {
        String corpo = "Receita com id: " + r.getId() + " encontra-se pendente de aprovação.";
        String assunto = "Receita pendente de aprovação";
        List<Usuario> usuarios = usuarioService.findAdmin();

        for (int i = 0; i < usuarios.size(); i++) {
            emailService.sendMail(usuarios.get(i).getEmail(), corpo, assunto);
        }
    }

    public Receita edit(ReceitaDto dto) throws Exception {
        return receitaRepository.saveAndFlush(validaUpdate(dto));
    }

    public List<Receita> findAll() {
        return receitaRepository.findAll();
    }

    public List<Receita> findTopFive() {
        return receitaRepository.findTop5ByOrderByVotoDesc();
    }

    public Receita findById(Long id) throws Exception {
        Optional<Receita> retorno = receitaRepository.findById(id);
        if (retorno.isPresent())
            return retorno.get();
        else
            throw new Exception("Receita com ID: " + id + " não identificada!");
    }

    public List<Receita> findByFilters(String descricao) {
        return receitaRepository.findByDescricaoContainingAllIgnoringCase(descricao);
    }

    public List<Receita> findByCategoria(Long categoriaId) {
        return receitaRepository.findByCategoriaId(categoriaId);
    }

    public List<Long> findIdReceitaWithVoto() {
        return receitaRepository.findIdReceitaWithVoto();
    }

    private Receita validaInsert(ReceitaDto dto) throws Exception {

        Receita r = new Receita();

        if (dto.getId() != null)
            throw new Exception("Para inserir uma nova receita, não deve-se informar o ID");
//        if (findByFilters(dto.getDescricao()) != null) {
//            throw new Exception("Receita com a mesma descrição já inserida");
//        }
        r.setDescricao(dto.getDescricao());
        if (dto.getImagem() != null)
            r.setImagem(Util.compressData(dto.getImagem()));
        r.setAtivo(dto.isAtivo());
        if(dto.getCategoriaId() != null)
            r.setCategoria(categoriaService.findById(dto.getCategoriaId()));
        r.setUsuario(dto.getUsuario());
        r.setVoto(dto.getVoto());

        return r;

    }

    private Receita validaUpdate(ReceitaDto dto) throws Exception {

        if (dto.getId() == null)
            throw new Exception("Para atualizar uma receita, deve-se informar o ID");

        Receita r = findById(dto.getId());

        if (findByFilters(dto.getDescricao()) != null)
            throw new Exception("Receita com a mesma descrição já inserida");

        r.setId(dto.getId());
        r.setDescricao(dto.getDescricao());
        r.setImagem(Util.compressData(dto.getImagem()));
        r.setAtivo(dto.isAtivo());
        if(dto.getCategoriaId() != null)
            r.setCategoria(categoriaService.findById(dto.getCategoriaId()));
        r.setUsuario(dto.getUsuario());
        r.setVoto(dto.getVoto());
        return r;

    }

    public void updateVoto(Long idReceita, int voto) throws Exception {
        Receita receita = findById(idReceita);
        receita.setVoto(voto);
        receitaRepository.saveAndFlush(receita);
    }
}
