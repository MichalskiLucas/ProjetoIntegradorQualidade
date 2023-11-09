package br.integration.cookmasterapi.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiModel;
import lombok.Data;

@Entity
@Table(name = "usuario")
@ApiModel(description = "Modelo para representação de uma entidade usuario")
@Api
@Data
public class Usuario {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank
    @NotEmpty
    @NotNull
    private String nome;

    @NotBlank
    @NotEmpty
    @NotNull
    private String email;

    private boolean admin = false;
}
