package br.integration.cookmasterapi.dto;

import br.integration.cookmasterapi.model.Sacola;
import lombok.Data;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import java.util.zip.DataFormatException;

@Data
public class SacolaDto extends BaseDto<Sacola, SacolaDto> {

    private Long id;
    private Long idUsuario;
    private List<Long> idIngredientes = new ArrayList<>();

    @Override
    public SacolaDto getInstance(Sacola entity) throws IOException, DataFormatException {
        if (entity != null) {
            SacolaDto dto = new SacolaDto();

            dto.setId(entity.getId());
            dto.setIdUsuario(entity.getUsuario().getId());
            for(int i = 0; i <= entity.getIngredientes().size(); i++){
                dto.idIngredientes.add(entity.getIngredientes().get(i).getId());
            }
            return dto;
        } else
            return null;
    }

    @Override
    public List<SacolaDto> getListInstance(List<Sacola> list) {
        return list.stream().map((Sacola s) -> {
            try {
                return getInstance(s);
            } catch (IOException e) {
                throw new RuntimeException(e);
            } catch (DataFormatException e) {
                throw new RuntimeException(e);
            }
        }).collect(Collectors.toList());
    }
}
