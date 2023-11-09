package br.integration.cookmasterapi.dto;

import br.integration.cookmasterapi.enums.EnumUnitMeasure;
import br.integration.cookmasterapi.model.Receita;
import br.integration.cookmasterapi.model.ReceitaIngrediente;
import br.integration.cookmasterapi.util.Util;
import lombok.Data;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;
import java.util.zip.DataFormatException;

@Data
public class ReceitaIngredienteDto extends BaseDto<ReceitaIngrediente, ReceitaIngredienteDto> {

    private Long id;
    private Long ingredienteId;
    private Long receitaId;
    private Double qtdIngrediente;
    private EnumUnitMeasure unMedida;

    @Override
    public ReceitaIngredienteDto getInstance(ReceitaIngrediente entity) throws IOException, DataFormatException {
        if (entity != null) {

            ReceitaIngredienteDto dto = new ReceitaIngredienteDto();

            if(entity.getReceita() != null)
                dto.setReceitaId(entity.getReceita().getId());

            if(entity.getIngrediente() != null)
                dto.setIngredienteId(entity.getIngrediente().getId());

            dto.setQtdIngrediente(entity.getQtdIngrediente());
            dto.setUnMedida(entity.getUnMedida());

            return dto;
        } else
            return null;
    }

    @Override
    public List<ReceitaIngredienteDto> getListInstance(List<ReceitaIngrediente> list) {
        return list.stream().map((ReceitaIngrediente r) -> {
            try {
                return getInstance(r);
            } catch (IOException | DataFormatException e) {
                throw new RuntimeException(e);
            }
        }).collect(Collectors.toList());
    }
}
