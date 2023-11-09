package br.integration.cookmasterapi.dto;

import br.integration.cookmasterapi.model.Receita;
import br.integration.cookmasterapi.model.Voto;
import br.integration.cookmasterapi.util.Util;
import lombok.Data;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;
import java.util.zip.DataFormatException;

@Data
public class VotoDto extends BaseDto<Voto, VotoDto> {

    private Long id;
    private Long idUsuario;
    private Long idReceita;
    private int voto;

    @Override
    public VotoDto getInstance(Voto entity) throws IOException, DataFormatException {
        if (entity != null) {
            VotoDto dto = new VotoDto();

            dto.setId(entity.getId());
            dto.setIdUsuario(entity.getUsuario().getId());
            dto.setIdReceita(entity.getReceita().getId());
            dto.setVoto(entity.getVoto());
            return dto;
        } else
            return null;
    }

    @Override
    public List<VotoDto> getListInstance(List<Voto> list) {
        return list.stream().map((Voto v) -> {
            try {
                return getInstance(v);
            } catch (IOException e) {
                throw new RuntimeException(e);
            } catch (DataFormatException e) {
                throw new RuntimeException(e);
            }
        }).collect(Collectors.toList());
    }
}
