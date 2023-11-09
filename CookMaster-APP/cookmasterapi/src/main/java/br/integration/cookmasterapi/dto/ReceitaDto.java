package br.integration.cookmasterapi.dto;

import br.integration.cookmasterapi.model.Categoria;
import br.integration.cookmasterapi.model.Receita;
import br.integration.cookmasterapi.model.Usuario;
import br.integration.cookmasterapi.util.Util;
import lombok.Data;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;
import java.util.zip.DataFormatException;

@Data
public class ReceitaDto extends BaseDto<Receita, ReceitaDto> {

    private Long id;
    private String descricao;
    private boolean ativo;
    private String imagem;
    private Usuario usuario;
    private int voto;
    private Long categoriaId;

    @Override
    public ReceitaDto getInstance(Receita entity) throws IOException, DataFormatException {
        if (entity != null) {
            ReceitaDto dto = new ReceitaDto();

            dto.setId(entity.getId());
            dto.setDescricao(entity.getDescricao());
            dto.setAtivo(entity.isAtivo());
            if(entity.getImagem() !=null)
                dto.setImagem(Util.decompress(entity.getImagem()));

            dto.setUsuario(entity.getUsuario());
            dto.setVoto(entity.getVoto());
            if(entity.getCategoria() != null)
                dto.setCategoriaId(entity.getCategoria().getId());
            return dto;
        } else
            return null;
    }

    @Override
    public List<ReceitaDto> getListInstance(List<Receita> list) {
        return list.stream().map((Receita r) -> {
            try {
                return getInstance(r);
            } catch (IOException | DataFormatException e) {
                throw new RuntimeException(e);
            }
        }).collect(Collectors.toList());

    }
}



