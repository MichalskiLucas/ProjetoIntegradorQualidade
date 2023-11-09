package br.integration.cookmasterapi.dto;

import br.integration.cookmasterapi.enums.EnumUnitMeasure;
import lombok.Data;

@Data
public class IngredienteCompostoDto {
    private Long ingredienteId;
    private Double qtdIngrediente;
    private EnumUnitMeasure unMedida;

    /*

    "id": 3,
    "descricao": "Ovo",
    "quantidade": 10,
    "unMedida": "KG"

    */
}
