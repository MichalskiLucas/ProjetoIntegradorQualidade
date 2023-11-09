package br.integration.cookmasterapi.model;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

import lombok.*;
import org.hibernate.annotations.Type;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiModel;

@Entity
@Table(name = "preparo")
@ApiModel(description = "Modelo para representação de um passo de preparo")
@Api
@Data
public class Preparo {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank
    @NotEmpty
    @NotNull
    private String descricao;

    @ManyToOne(cascade = {CascadeType.MERGE, CascadeType.PERSIST})
    private Receita receita;

}
