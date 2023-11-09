package br.integration.cookmasterapi.dto;

import br.integration.cookmasterapi.model.Categoria;
import br.integration.cookmasterapi.util.Util;
import lombok.Data;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;
import java.util.zip.DataFormatException;

@Data
public class CategoriaDto extends BaseDto<Categoria, CategoriaDto> {

    private Long id;
    private String descricao;
    private String imagem;

    @Override
    public CategoriaDto getInstance(Categoria entity) throws IOException, DataFormatException {
        if (entity != null) {
            CategoriaDto dto = new CategoriaDto();

            dto.setId(entity.getId());
            dto.setDescricao(entity.getDescricao());

            if(entity.getImagem()!=null)
                dto.setImagem(Util.decompress(entity.getImagem()));

            return dto;
        } else
            return null;
    }

    @Override
    public List<CategoriaDto> getListInstance(List<Categoria> list) {
        return list.stream().map((Categoria c) -> {
            try {
                return getInstance(c);
            } catch (IOException | DataFormatException e) {
                throw new RuntimeException(e);
            }
        }).collect(Collectors.toList());

    }
};
