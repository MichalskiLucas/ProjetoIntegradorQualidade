package br.integration.cookmasterapi.dto;

import lombok.Data;

@Data
public class PreparoDto {

    private Long id;
    private String descricao;
    private Long receitaId;
}
