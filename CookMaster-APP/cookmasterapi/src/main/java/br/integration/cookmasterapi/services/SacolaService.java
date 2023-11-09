package br.integration.cookmasterapi.services;

import br.integration.cookmasterapi.dto.SacolaDto;
import br.integration.cookmasterapi.model.Ingrediente;
import br.integration.cookmasterapi.model.Sacola;
import br.integration.cookmasterapi.repository.SacolaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;


@Service
public class SacolaService {

    @Autowired
    private SacolaRepository sacolaRepository;

    @Autowired
    private UsuarioService usuarioService;

    @Autowired
    private IngredienteService ingredienteService;

    public Sacola insert(SacolaDto dto) throws Exception {
        return sacolaRepository.saveAndFlush(validaInsert(dto));
    }

    public Sacola edit(SacolaDto dto) throws Exception {
        return sacolaRepository.saveAndFlush(validaUpdate(dto));

    }

    public List<Sacola> findAll() {
        return sacolaRepository.findAll();
    }

    public Sacola findById(Long id) throws Exception {
        Optional<Sacola> retorno = sacolaRepository.findById(id);
        if (retorno.isPresent()) return retorno.get();
        else throw new Exception("Sacola com ID: " + id + " não identificado!");
    }

    public Sacola findByUsuarioId(Long usuarioId) {
        return sacolaRepository.findSacolaByUsuarioId(Optional.ofNullable(usuarioId));
    }

    private Sacola validaInsert(SacolaDto sacolaDto) throws Exception {

        List<Ingrediente> ingredientes = new ArrayList<>();
        Sacola sacola = new Sacola();

        if (sacolaDto.getIdUsuario() != null) {
            sacola.setUsuario(usuarioService.findById(sacolaDto.getIdUsuario()));
        } else {
            throw new Exception("Para criar uma sacola, deve-se informar o ID do usuário");
        }

        if (!sacolaDto.getIdIngredientes().isEmpty()) {
            for (int i = 0; i < sacolaDto.getIdIngredientes().size(); i++) {
                ingredientes.add(ingredienteService.findById(sacolaDto.getIdIngredientes().get(i)));
            }
        }

        if (sacolaDto.getId() != null)
            sacola.setId(sacolaDto.getId());
            sacola.setIngredientes(ingredientes);
        return sacola;
    }


    private Sacola validaUpdate(SacolaDto sacolaDto) throws Exception {

        List<Ingrediente> ingredientes = new ArrayList<>();
        Sacola sacola = new Sacola();

        if (sacolaDto.getId() != null) {
            sacola = findById(sacolaDto.getId());
        } else {
            throw new Exception("Para atualizar uma sacola, deve-se informar o ID.");
        }

        if (sacolaDto.getIdUsuario() != null) {
            sacola.setUsuario(usuarioService.findById(sacolaDto.getIdUsuario()));
        } else {
            throw new Exception("Para criar uma sacola, deve-se informar o ID do usuário");
        }

        if (!sacolaDto.getIdIngredientes().isEmpty()) {
            for (int i = 0; i < sacolaDto.getIdIngredientes().size(); i++) {
                ingredientes.add(ingredienteService.findById(sacolaDto.getIdIngredientes().get(i)));
            }
        }

        if (sacolaDto.getId() != null)
            sacola.setId(sacolaDto.getId());
            sacola.setIngredientes(ingredientes);
        return sacola;
    }
}
