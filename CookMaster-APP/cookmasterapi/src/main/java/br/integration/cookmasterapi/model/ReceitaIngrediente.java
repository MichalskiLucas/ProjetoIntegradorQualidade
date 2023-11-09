package br.integration.cookmasterapi.model;

import java.util.List;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

import br.integration.cookmasterapi.enums.EnumUnitMeasure;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiModel;
import lombok.Data;

@Entity
@Table(name = "receitaingrediente")
@ApiModel(description = "Modelo para representação de uma entidade ReceitaIngrediente")
@Api
@Data
public class ReceitaIngrediente {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne
    private Ingrediente ingrediente;

    @ManyToOne(cascade = {CascadeType.MERGE, CascadeType.PERSIST})
    private Receita receita;

    @NotBlank
    @NotEmpty
    @NotNull
    private Double qtdIngrediente;

    @NotBlank
    @NotEmpty
    @NotNull
    @Enumerated(EnumType.STRING)
    private EnumUnitMeasure unMedida;
}
