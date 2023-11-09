package br.integration.cookmasterapi.model;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiModel;
import lombok.Data;
import org.hibernate.annotations.Type;

import java.util.ArrayList;
import java.util.List;

@Data
@Entity
@Table(name = "receita")
@ApiModel(description = "Modelo para representação de uma receita")
@Api
public class Receita {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank
    @NotEmpty
    @NotNull
    private String descricao;

    private int voto;

    private boolean ativo;

    @Type(type = "org.hibernate.type.BinaryType")
    private byte[] imagem;

    @ManyToOne
    private Usuario usuario;

    @OneToOne
    private Categoria categoria;

}
